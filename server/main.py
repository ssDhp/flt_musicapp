from fastapi import FastAPI

from models.base_class import BaseClass
from routes import auth, song 
from database import sql_engine

app = FastAPI()
app.include_router(auth.router, prefix="/auth")
app.include_router(song.router, prefix="/song")

# Create tables if not exists
BaseClass.metadata.create_all(sql_engine)


@app.get("/")
def get_hello():
    return "hello world"
