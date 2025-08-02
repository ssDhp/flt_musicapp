from sqlalchemy import TEXT, VARCHAR, Column
from models.base_class import BaseClass


class Song(BaseClass):
    __tablename__ = "song"
    id = Column(TEXT, primary_key=True)
    song_url = Column(TEXT)
    thumbnail_url = Column(TEXT)
    artist = Column(TEXT)
    song_name = Column(VARCHAR(100))
    hex_code = Column(VARCHAR(6))
