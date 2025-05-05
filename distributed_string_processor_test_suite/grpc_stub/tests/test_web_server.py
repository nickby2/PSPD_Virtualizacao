from starlette.testclient import TestClient
from grpc_stub.web_server import app

client = TestClient(app)

def test_web_server_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}

def test_web_server_string_processing():
    response = client.post("/process", json={"input_string": "test string"})
    assert response.status_code == 200
    assert response.json() == {"processed_string": "TEST STRING"}
