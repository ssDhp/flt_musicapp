from fastapi import Depends, HTTPException, Header
import jwt

from database import get_db
from constants.server_constants import PRIVATE_KEY


def auth_middleware(x_auth_token=Header(), db=Depends(get_db)):
    try:
        if not x_auth_token:
            HTTPException(401, "No auth token, access denied!")

        decoded_dict = jwt.decode(x_auth_token, PRIVATE_KEY, "HS256")
        id = decoded_dict.get("id")

        return {"uuid": id, "token": x_auth_token}

    except jwt.exceptions.DecodeError:
        raise HTTPException(401, "Token validation failed, access denied!")

    except jwt.exceptions.InvalidTokenError:
        raise HTTPException(401, "Token decoding failed, access denied!")
