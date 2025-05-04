#!/bin/bash
# Script para compilar os servidores C++ individualmente

echo "Compilando servidores C++..."

# 1. Verificar dependências
check_dependency() {
    if ! command -v $1 &> /dev/null; then
        echo "Erro: $1 não encontrado. Instale com:"
        echo "sudo apt-get install $2"
        exit 1
    fi
}

check_dependency "g++" "g++"
check_dependency "protoc" "protobuf-compiler"
check_dependency "grpc_cpp_plugin" "libgrpc++-dev"

# 2. Gerar arquivos protobuf
echo "Gerando arquivos gRPC..."
protoc -Iproto --cpp_out=cpp_server_a/ proto/string_processor.proto
protoc -Iproto --grpc_out=cpp_server_a/ --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` proto/string_processor.proto

protoc -Iproto --cpp_out=cpp_server_b/ proto/string_processor.proto
protoc -Iproto --grpc_out=cpp_server_b/ --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` proto/string_processor.proto

# 3. Compilar Server A (Uppercase)
echo "Compilando Server A..."
g++ -std=c++11 -Icpp_server_a/ -I/usr/local/include \
    cpp_server_a/server_a.cpp \
    cpp_server_a/string_processor.pb.cc \
    cpp_server_a/string_processor.grpc.pb.cc \
    -L/usr/local/lib -lgrpc++ -lprotobuf -lpthread -ldl -o server_a

# 4. Compilar Server B (Reverse)
echo "Compilando Server B..."
g++ -std=c++11 -Icpp_server_b/ -I/usr/local/include \
    cpp_server_b/server_b.cpp \
    cpp_server_b/string_processor.pb.cc \
    cpp_server_b/string_processor.grpc.pb.cc \
    -L/usr/local/lib -lgrpc++ -lprotobuf -lpthread -ldl -o server_b

echo "Servidores compilados:"
echo "- Server A (Uppercase): ./server_a"
echo "- Server B (Reverse):   ./server_b"
