#include <iostream>
#include <string>
#include <algorithm>
#include <grpcpp/grpcpp.h>
#include "string_processor.grpc.pb.h"

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::Status;
using stringprocessor::StringRequest;
using stringprocessor::StringResponse;
using stringprocessor::StringService;

class StringServiceImpl final : public StringService::Service {
    Status Process(ServerContext* context, const StringRequest* request, StringResponse* response) override {
        std::string text = request->text();
        std::reverse(text.begin(), text.end());
        response->set_result(text);
        return Status::OK;
    }
};

void RunServer() {
    std::string server_address("0.0.0.0:50052");
    StringServiceImpl service;
    ServerBuilder builder;
    builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
    builder.RegisterService(&service);
    std::unique_ptr<Server> server(builder.BuildAndStart());
    std::cout << "Server B (Reverse) listening on " << server_address << std::endl;
    server->Wait();
}

int main() {
    RunServer();
    return 0;
}
