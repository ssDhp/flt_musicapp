import os
import uuid
import cloudinary
import cloudinary.uploader
from cloudinary.utils import cloudinary_url
from fastapi import APIRouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import Session
from dotenv import load_dotenv

from database import get_db
from middleware.auth_middleware import auth_middleware
from models.song import Song

router = APIRouter()
load_dotenv()

cloudinary.config(
    cloud_name="doq8m1c8d",
    api_key="655479175988511",
    api_secret=os.getenv("CLOUDINARY_SECERT"),
    secure=True,
)


@router.post("/upload", status_code=201)
def upload_song(
    song: UploadFile = File(...),
    thumbnail: UploadFile = File(...),
    artist: str = Form(...),
    song_name: str = Form(...),
    hex_code: str = Form(...),
    db: Session = Depends(get_db),
    auth_dic: object = Depends(auth_middleware),
):

    song_id = str(uuid.uuid4())
    song_res = cloudinary.uploader.upload(
        song.file, resource_type="auto", folder=f"songs/{song_id}"
    )
    thumbnail_res = cloudinary.uploader.upload(
        thumbnail.file, resource_type="image", folder=f"songs/{song_id}"
    )
    song_url = song_res["url"]
    thumbnail_url = thumbnail_res["url"]

    new_song = Song(
        id=song_id,
        song_url=song_url,
        thumbnail_url=thumbnail_url,
        artist=artist,
        song_name=song_name,
        hex_code=hex_code,
    )

    db.add(new_song)
    db.commit()
    db.refresh(new_song)

    return new_song


@router.get("/list")
def list_songs(
    db: Session = Depends(get_db),
    auth_dict: object = Depends(auth_middleware),
):
    songs = db.query(Song).all()
    return songs
