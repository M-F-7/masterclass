from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {"hello": "world"}

@app.get("/predict")
def predict():
    return {"/predict"}



