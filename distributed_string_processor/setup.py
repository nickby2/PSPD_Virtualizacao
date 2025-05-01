from setuptools import setup, find_packages

setup(
    name="distributed_string_processor",
    version="0.1",
    packages=find_packages(),
    package_data={
        'grpc_stub': ['*.py', 'templates/*'],
        'proto': ['*.proto'],
    },
    install_requires=[
        'grpcio>=1.58.0',
        'protobuf>=3.20.3',
        'fastapi>=0.95.2',
        'uvicorn>=0.18.3',
    ],
)
