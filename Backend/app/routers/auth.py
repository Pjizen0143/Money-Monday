from fastapi import APIRouter, HTTPException
from app.models.user import User, UserUpdate
from app.db import SessionDep
from app.crud.user import verify_password
from sqlmodel import select

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/login")
def login( session: SessionDep, form_data: UserUpdate):
    # หา user จาก username
    user = session.exec(select(User).where(User.username == form_data.username)).first()
    if not user or not verify_password(form_data.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid username or password")
    return user