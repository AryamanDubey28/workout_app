from .. import db
from sqlalchemy import String, Integer, Float, ForeignKey
from sqlalchemy.orm import mapped_column



class Exercise(db.Model):
    __tablename__ = "exercises"
    id = mapped_column(Integer, primary_key=True)
    user_id = mapped_column(String, ForeignKey('users.id'), nullable=False)
    name = mapped_column(String(80), nullable=False)
    muscles_worked = mapped_column(String(255), nullable=False)  # store as comma-separated string
    weight = mapped_column(Float, nullable=True)

    def __repr__(self):
        return f"<Exercise(id={self.id}, name={self.name}, muscles_worked={self.muscles_worked}, weight={self.weight})>"