import grpc
import string_processor_pb2 as sp_pb2
import string_processor_pb2_grpc as sp_pb2_grpc


class StringProcessorClient:
    def __init__(self):
        self.server_a_channel = grpc.insecure_channel('localhost:50051')
        self.server_b_channel = grpc.insecure_channel('localhost:50052')
        self.stub_a = sp_pb2_grpc.StringServiceStub(self.server_a_channel)
        self.stub_b = sp_pb2_grpc.StringServiceStub(self.server_b_channel)

    def process_string(self, text: str) -> str:
        response_a = self.stub_a.Process(sp_pb2.StringRequest(text=text))
        response_b = self.stub_b.Process(sp_pb2.StringRequest(text=response_a.result))
        return response_b.result
