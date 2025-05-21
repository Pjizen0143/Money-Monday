from fastapi import APIRouter, HTTPException
from app.models.user import UserPublic, UserCreate, User
from app.db import SessionDep
from sqlmodel import select
from app.crud.user import create_user, read_user, read_user_by_id

router = APIRouter(prefix="/users", tags=["users"])

@router.post("/register", response_model=UserPublic)
def register_user(user: UserCreate, session: SessionDep):
    existing = session.exec(
        select(User).where(User.username == user.username)
    ).first()
    if existing:
        raise HTTPException(status_code=400, detail="Username already exists")

    existing_email = session.exec(
        select(User).where(User.email == user.email)
    ).first()
    if existing_email:
        raise HTTPException(status_code=400, detail="Email already exists")
    return create_user(session=session, user_data=user)

@router.get("/", response_model=list[UserPublic])
def get_user(session: SessionDep):
    return read_user(session=session)

@router.get("/{user_id}")
def get_user_by_id(session: SessionDep, user_id: int):
    return read_user_by_id(session=session, user_id=user_id)