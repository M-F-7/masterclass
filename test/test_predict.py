from fastapi.testclient import TestClient
from src.app import app

client = TestClient(app)

def test_predict_valid_input():
    payload = {
        "features": [3, 22, 1, 0, 7.25, 1, 0, 1]
    }

    response = client.post("/predict", json=payload)

    assert response.status_code == 200
    print(response.json())
    data = response.json()

    assert "prediction" in data
    assert data["prediction"] in [0, 1]
