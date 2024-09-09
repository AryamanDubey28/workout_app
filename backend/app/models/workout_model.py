from .. import db
from sqlalchemy import String, Integer, Date
from sqlalchemy.orm import mapped_column


class Workout(db.Model):
    __tablename__ = "workouts"
    id = mapped_column(Integer, primary_key=True)
    date = mapped_column(Date, nullable=False, unique=True)
    pushup = mapped_column(String(80), nullable=False)
    pullup = mapped_column(String(80), nullable=False)
    squat = mapped_column(String(80), nullable=False)

    def __repr__(self):
        return f"<Workout(id={self.id}, date={self.date}, pushup={self.pushup}, pullup={self.pullup}, squat={self.squat})>"
