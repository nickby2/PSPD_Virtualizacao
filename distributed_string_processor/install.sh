#!/bin/bash
# Script de instalação para o Distributed String Processor

echo "🔧 Configurando ambiente..."

# 1. Criar e ativar ambiente virtual
python3 -m venv venv
source venv/bin/activate

# 2. Instalar dependências básicas
pip install --upgrade pip
pip install grpcio==1.58.0 grpcio-tools==1.58.0 protobuf==3.20.3

# 3. Gerar arquivos gRPC
echo "🛠️  Gerando arquivos gRPC..."
python -m grpc_tools.protoc -Iproto --python_out=grpc_stub --grpc_python_out=grpc_stub proto/string_processor.proto

# 4. Instalar dependências do servidor web
pip install fastapi==0.95.2 uvicorn==0.21.1 python-multipart==0.0.6 Jinja2==3.1.2

# 5. Configurar pacote
echo "📦 Configurando pacote Python..."
cat > setup.py <<EOF
from setuptools import setup, find_packages

setup(
    name="distributed_string_processor",
    version="0.1",
    packages=find_packages(),
    package_data={
        'grpc_stub': ['*.py', 'templates/*'],
        'proto': ['*.proto'],
    },
)
EOF

pip install -e .

echo "✅ Instalação concluída!"
echo "👉 Execute os servidores conforme instruções no README.md"
