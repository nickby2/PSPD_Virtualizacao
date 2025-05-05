import grpc
from grpc_stub.string_processor_pb2 import StringRequest
from grpc_stub.string_processor_pb2_grpc import StringProcessorStub

class StringProcessorClient:
    def __init__(self, channel):
        self.stub = StringProcessorStub(channel)

    def process_string(self, input_str: str) -> str:
        request = StringRequest(input=input_str)
        response = self.stub.ProcessString(request)
        return response.result
