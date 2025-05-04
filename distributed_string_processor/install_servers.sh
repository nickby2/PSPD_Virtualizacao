#!/bin/bash
# Script de instalação para os servidores C++ do Distributed String Processor

echo "🔧 Instalando dependências para os servidores C++..."

# 1. Instalar dependências do sistema
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    cmake \
    git \
    libgrpc++-dev \
    libprotobuf-dev \
    protobuf-compiler \
    protobuf-compiler-grpc

# 2. Verificar versões instaladas
echo "Versões instaladas:"
protoc --version
which grpc_cpp_plugin

# 3. Compilar Server A (Uppercase)
echo "Compilando Server A..."
cd cpp_server_a
mkdir -p build && cd build
cmake ..
make
cp server_a ../..
cd ../..

# 4. Compilar Server B (Reverse)
echo "Compilando Server B..."
cd cpp_server_b
mkdir -p build && cd build
cmake ..
make
cp server_b ../..
cd ../..

echo "Servidores compilados com sucesso!"
echo "Arquivos executáveis: ./server_a e ./server_b"
