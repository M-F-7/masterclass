from fastapi import FastAPI
from fastapi.responses import FileResponse
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import joblib
import numpy as np

# Charger le modèle au démarrage
model = joblib.load("/app/models/model.joblib")

app = FastAPI(title="Masterclass", description="Masterclass using FAstAPI to deploy a model of classification for the titanic dataset")

app.mount("/static", StaticFiles(directory="/app/src/static"), name="static")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


# Définir le schéma d'entrée
class InputData(BaseModel):
    features: list[float]

@app.get('/')
def home():
    return {"message": "Home"}

@app.get("/predict")
def serve_predict_page():
    return FileResponse("/app/src/static/index.html")


@app.post("/predict")
def predict(data: InputData):
    # Convertir en array 2D
    X = np.array(data.features).reshape(1, -1)

    # Faire la prédiction
    prediction = model.predict(X)[0]
    proba = model.predict_proba(X)[0].tolist()

    return {
        "prediction": int(prediction),
        "probabilities": proba
    }

# Pclass, -> 1,2,3, int
# Age -> 0-150, int
# SibSp, 0-*, int
# Parch, 0-*, int
# Fare, 0-*, float
# Sex_male, 1 = male, 0 = female, int
# Embarked_Q, 1 = yes, 0 = no
# Embarked_S, 1 = yes, 0 = no
# if both are set to 0,     
# C = Cherbourg, Q = Queenstown, S = Southampton