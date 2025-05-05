from typing import Annotated

from fastapi import Query
from sqlmodel import select
from app.models.user import User, UserCreate  # import model และ schema
from app.db import SessionDep

def create_user(session: SessionDep, user_data: UserCreate) -> User:
    db_user = User.model_validate(user_data)  # แปลงจาก schema เป็น model
    session.add(db_user)
    session.commit()
    session.refresh(db_user)
    return db_user

def read_user_by_id(session: SessionDep, user_id: int) -> User:
    user = session.get(User, user_id)
    return user

def read_user(session: SessionDep, offset=0, limit: Annotated[int, Query(le=100)] = 100):
    user = session.exec(select(User).offset(offset).limit(limit)).all()
    return user