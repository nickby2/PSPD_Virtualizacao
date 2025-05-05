import pytest
from starlette.testclient import TestClient
from grpc_stub.web_server import app

@pytest.fixture
def client():
    return TestClient(app)
