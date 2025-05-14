from app.db import create_db_and_tables
from fastapi import  FastAPI
from app.routers import user, auth

app = FastAPI()

@app.on_event("startup")
def on_startup():
    create_db_and_tables()

app.include_router(user.router)
app.include_router(auth.router)