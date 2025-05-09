from sqlmodel import Field, SQLModel
from pydantic import EmailStr

# Base schema (ใช้สำหรับ shared fields)
class UserBase(SQLModel):
    username: str = Field(index=True)


# Model สำหรับ table จริงในฐานข้อมูล
class User(UserBase, table=True):
    id: int | None = Field(default=None, primary_key=True)
    email: EmailStr
    password: str


# Model สำหรับส่งข้อมูลออก (เช่น API response)
class UserPublic(UserBase):
    id: int
    email: EmailStr


# Model สำหรับการสร้าง User
class UserCreate(UserBase):
    email: EmailStr
    password: str


# Model สำหรับการอัปเดต User (ไม่ต้องระบุทั้งหมด)
class UserUpdate(SQLModel):
    username: str | None = None
    email: EmailStr | None = None
    password: str | None = None
