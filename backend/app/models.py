from . import db
from sqlalchemy import String, Integer, Date,Float
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


class Exercise(db.Model):
    __tablename__ = "exercises"
    id = mapped_column(Integer, primary_key=True)
    name = mapped_column(String(80), nullable=False)
    muscles_worked = mapped_column(String(255), nullable=False)  # store as comma-separated string
    weight = mapped_column(Float, nullable=True)

    def __repr__(self):
        return f"<Exercise(id={self.id}, name={self.name}, muscles_worked={self.muscles_worked}, weight={self.weight})>"