from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# DB URL Schema: postgresql://<user name>:<password>@<address>:<port>/<db name>
DB_URL = "postgresql://postgres:Ashu8126@localhost:5432/flt_musicappdb"
sql_engine = create_engine(DB_URL)
session_local = sessionmaker(sql_engine, autoflush=False)
db = session_local()


def get_db():
    try:
        yield db
    finally:
        db.close()
