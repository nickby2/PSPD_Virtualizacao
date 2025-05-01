from fastapi import FastAPI, Request, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
from client import StringProcessorClient

app = FastAPI()
templates = Jinja2Templates(directory="templates")
processor = StringProcessorClient()

@app.get("/", response_class=HTMLResponse)
async def home(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.post("/process", response_class=HTMLResponse)
async def process_string(request: Request, text: str = Form(...)):
    try:
        result = processor.process_string(text)
        return templates.TemplateResponse("index.html", {"request": request, "result": result, "original": text})
    except Exception as e:
        return templates.TemplateResponse("index.html", {"request": request, "error": str(e)})
