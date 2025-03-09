from sqlalchemy import Column, TEXT, VARCHAR, LargeBinary

from models.base_class import BaseClass

class User(BaseClass):
    __tablename__ = "app_users"
    id = Column(TEXT, primary_key=True)
    name = Column(VARCHAR(100))
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)