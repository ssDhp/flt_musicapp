from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class NewUser(BaseModel):
    name: str
    email: str
    password: str

@app.post('/signup')
def signup_user(user: NewUser):
    print(user)
    pass