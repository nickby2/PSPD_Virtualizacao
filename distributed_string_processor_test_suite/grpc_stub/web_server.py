# grpc_stub/web_server.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

@app.get("/health")
def health_check():
    return {"status": "ok"}

class InputData(BaseModel):
    input_string: str

@app.post("/process")
def process_string(data: InputData):
    # Simula o processamento (ex: transforma em maiúsculas)
    processed = data.input_string.upper()
    return {"processed_string": processed}
