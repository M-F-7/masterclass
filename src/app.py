from fastapi import FastAPI
from fastapi.responses import FileResponse
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import joblib
import numpy as np

#load the model
model = joblib.load("/app/models/model.joblib")

app = FastAPI(title="Masterclass", description="Masterclass using FAstAPI to deploy a model of classification for the titanic dataset")

app.mount("/static", StaticFiles(directory="/app/src/static"), name="static") #we can access to static file from /static

app.add_middleware( # allow the communication between front end and backend
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Base model use to have a good format 
class InputData(BaseModel):
    features: list[float]

@app.get('/')
def home():
    return FileResponse("/app/src/static/home.html")

@app.get("/predict")
def serve_predict_page():
    return FileResponse("/app/src/static/index.html")

@app.get("/health")
def health():
    return {"status": "ok"}



@app.post("/predict")
def predict(data: InputData):
    # Convert to an array 2D
    X = np.array(data.features).reshape(1, -1)

    # predict
    prediction = model.predict(X)[0] # only one passenger is asking -> so only need to take the first element
    proba = model.predict_proba(X)[0].tolist()

    survival_proba = float(proba[1]) # taking the part of the result if the passenger is alive
    percentage = round(survival_proba * 100, 2)

    message = f"Le passager a {percentage}% de chance de survivre."

    return {
        "prediction": int(prediction),
        "message": message
    }