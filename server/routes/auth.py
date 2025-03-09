from fastapi import HTTPException, APIRouter, Depends
import uuid
import bcrypt

from database import get_db
from schema.user_new import UserNew
from schema.user_login import UserLogin
from models.user import User

auth_router = APIRouter()

@auth_router.post("/signup", status_code=201)
def signup_user(new_user: UserNew, db = Depends(get_db)):

    # Check if user with same email already exists
    existing_user = db.query(User).filter(User.email == new_user.email).first()
    if existing_user is not None:
        raise HTTPException(400, "User with the same email already exists.")

    password_hashed = bcrypt.hashpw(new_user.password.encode(), bcrypt.gensalt())
    user_add = User(
        id=str(uuid.uuid4()),
        name=new_user.name,
        email=new_user.email,
        password=password_hashed,
    )
    db.add(user_add)
    db.commit()
    db.refresh(user_add)

    return user_add

@auth_router.post('/login')
def login_user(login_user: UserLogin, db = Depends(get_db)):
    
    # Check if user with same email already exists
    existing_user = db.query(User).filter(User.email == login_user.email).first()
    if existing_user is None:
        raise HTTPException(400, "User with this email doesn't exists!")
    
    # Check if password matches
    is_equal = bcrypt.checkpw(login_user.password.encode(), existing_user.password)

    if not is_equal:
        raise HTTPException(400, "Incorrect password!")
    
    return existing_user

