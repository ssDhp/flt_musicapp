from fastapi import FastAPI

from models.base_class import BaseClass
from routes.auth import auth_router
from database import sql_engine

app = FastAPI()
app.include_router(auth_router, prefix="/auth")

# Create tables if not exists
BaseClass.metadata.create_all(sql_engine)


@app.get("/")
def get_hello():
    return "hello world"
