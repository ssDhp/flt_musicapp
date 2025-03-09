from fastapi import FastAPI


from routes.auth import auth_router

app = FastAPI()
app.include_router(auth_router, prefix='/auth')


@app.get("/")
def get_hello():
    return "hello world"
