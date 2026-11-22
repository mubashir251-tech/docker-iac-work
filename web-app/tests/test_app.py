
import json

from app import app


def test_home_endpoint():
    app.config["TESTING"] = True

    with app.test_client() as client:
        response = client.get("/")

    assert response.status_code == 200

    data = response.get_json()

    assert data["message"] == "Hello from Docker IaC Lab!"
    assert "hostname" in data
    assert data["environment"] == "development"


def test_health_endpoint():
    app.config["TESTING"] = True

    with app.test_client() as client:
        response = client.get("/health")

    assert response.status_code == 200
    assert response.get_json() == {"status": "healthy"}
