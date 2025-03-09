from fastapi import FastAPI
from pydantic import BaseModel


class UserNew(BaseModel):
    name: str
    email: str
    password: str


app = FastAPI()


@app.get("/")
def get_hello():
    print(app.docs_url)
    print(app.redoc_url)
    print(app.openapi_url)
    return "hello world"


@app.post("/signup")
def signup_user(new_user: UserNew):
    return "OK"
