cmake_minimum_required(VERSION 3.10)

project(DistributedStringProcessorTests)

find_package(gRPC REQUIRED)
find_package(Protobuf REQUIRED)


include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../cpp_server_a)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../cpp_server_b)

add_executable(test_server_a test_server_a.cpp)
target_link_libraries(test_server_a gRPC::grpc++ protobuf::protobuf)

add_executable(test_server_b test_server_b.cpp)
target_link_libraries(test_server_b gRPC::grpc++ protobuf::protobuf)
