CXX = g++
CXXFLAGS = -std=c++11 -I. -I/usr/include/grpc -I/usr/include/protobuf
LDFLAGS = -lgrpc++ -lprotobuf -lpthread -lz -lgrpc++_unsecure -no-pie

PROTO_SRC = proto/string_processor.proto
CPP_SRC_A = cpp_server_a/server_a.cpp
CPP_SRC_B = cpp_server_b/server_b.cpp
OUT_A = server_a
OUT_B = server_b
WEB_SERVER_DIR = grpc_stub
WEB_SERVER = web_server.py

# Geração dos stubs
PROTO = $(PROTO_SRC:.proto=.pb.cc)

.PHONY: all clean run run_web run_all install_py_deps

# Compilar todos os componentes
all: server_a server_b

server_a: $(PROTO) $(CPP_SRC_A)
	$(CXX) $(CXXFLAGS) $(CPP_SRC_A) string_processor.pb.cc string_processor.grpc.pb.cc -o $(OUT_A) $(LDFLAGS)

server_b: $(PROTO) $(CPP_SRC_B)
	$(CXX) $(CXXFLAGS) $(CPP_SRC_B) string_processor.pb.cc string_processor.grpc.pb.cc -o $(OUT_B) $(LDFLAGS)

# Gerar os stubs
$(PROTO): $(PROTO_SRC)
	protoc -I proto --cpp_out=. --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` $(PROTO_SRC)

# Instalar dependências Python
install_py_deps:
	pip install -r $(WEB_SERVER_DIR)/requirements.txt

# Executar servidores C++
run: server_a server_b
	@echo "Iniciando Servidor A (Uppercase)..."
	./$(OUT_A) &
	@echo "Iniciando Servidor B (Reverse)..."
	./$(OUT_B) &
	@echo "Servidores C++ iniciados."

# Executar servidor web
run_web:
	@echo "Iniciando Servidor Web..."
	cd $(WEB_SERVER_DIR) && uvicorn $(WEB_SERVER):app --reload

# Executar todos os componentes
run_all: run run_web

# Limpeza
clean:
	rm -f $(OUT_A) $(OUT_B) string_processor.pb.cc string_processor.pb.h \
	string_processor.grpc.pb.cc string_processor.grpc.pb.h
