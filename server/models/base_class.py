from sqlalchemy.ext.declarative import declarative_base

import database

BaseClass = declarative_base()
BaseClass.metadata.create_all(database.sql_engine)
