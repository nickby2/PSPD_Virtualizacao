from unittest.mock import Mock
from grpc_stub.client import StringProcessorClient

def test_string_processor_client_initialization():
    mock_channel = Mock()
    client = StringProcessorClient(mock_channel)
    assert client is not None

def test_string_processing_with_mock():
    mock_channel = Mock()
    client = StringProcessorClient(mock_channel)

    mock_stub = Mock()
    mock_response = Mock()
    mock_response.result = "processed_string"
    mock_stub.ProcessString.return_value = mock_response
    client.stub = mock_stub

    result = client.process_string("test")
    assert result == "processed_string"
