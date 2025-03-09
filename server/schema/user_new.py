from pydantic import BaseModel


class UserNew(BaseModel):
    name: str
    email: str
    password: str
