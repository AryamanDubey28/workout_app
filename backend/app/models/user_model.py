from .. import db
from .journal_entry_model import JournalEntry
from sqlalchemy import String, Integer, Float, Boolean, DateTime,func
from sqlalchemy.orm import mapped_column
from datetime import datetime, date, timedelta


class User(db.Model):
    __tablename__ = "users"
    id = mapped_column(String(28), primary_key=True)
    email = mapped_column(String(120), unique=True, nullable=False)
    user_name = mapped_column(String(120), unique=True, nullable=False)
    age = mapped_column(Integer, nullable=False)
    gender = mapped_column(String(8), nullable=False)
    height = mapped_column(Float, nullable=False)  # in centimeters
    weight = mapped_column(Float, nullable=False)  # in kilograms
    steps_taken = mapped_column(Integer, default=0)
    worked_out_today = mapped_column(Boolean, default=False)
    streak = db.Column(db.Integer, default=0)
    last_workout_date = db.Column(db.Date, nullable=True)
    last_run = mapped_column(DateTime, nullable=True)

    def update_streak(self):
        """Updates user's streak of working out"""
        today = date.today()
        if self.last_workout_date == today:
            return  # No need to update streak if it's already done for today

        if self.last_workout_date == today - timedelta(days=1):
            self.streak += 1  # Continue the streak
        else:
            self.streak = 1  # Reset streak

        self.last_workout_date = today
        self.worked_out_today = True

    def log_run(self, distance_km, time_minutes):
        """Logs a run and calculates calories burned based on distance or time."""
        calories_burned = self.calculate_calories_burned(distance_km, time_minutes)
        self.worked_out_today = True
        self.last_run = datetime.now()
        return calories_burned

    def calculate_calories_burned(self, distance_km, time_minutes):
        """Simple formula to calculate calories burned."""
        MET = 9.8  # Metabolic equivalent for running (~9.8 METs for 8 km/h)
        weight_kg = self.weight

        # Calories burned = MET * weight_kg * time_hours
        time_hours = time_minutes / 60
        calories_burned = MET * weight_kg * time_hours

        # Adjust calories based on distance as a secondary factor
        calories_burned += 0.75 * weight_kg * distance_km  # Adjust multiplier as needed
        return calories_burned

    def get_stress_level_history(self, start_date=None, end_date=None):
        """
        Retrieves the stress level history for the user.

        :param start_date: Optional start date for the history (inclusive)
        :param end_date: Optional end date for the history (inclusive)
        :return: List of tuples (date, stress_level)
        """
        query = JournalEntry.query.filter_by(user_id=self.id).order_by(JournalEntry.date)

        if start_date:
            query = query.filter(JournalEntry.date >= start_date)
        if end_date:
            query = query.filter(JournalEntry.date <= end_date)

        return [(entry.date, entry.stress_level) for entry in query.all()]

    def get_average_stress_level(self, start_date=None, end_date=None):
        """
        Calculates the average stress level for the user.

        :param start_date: Optional start date for the calculation (inclusive)
        :param end_date: Optional end date for the calculation (inclusive)
        :return: Average stress level or None if no entries
        """
        query = JournalEntry.query.filter_by(user_id=self.id)

        if start_date:
            query = query.filter(JournalEntry.date >= start_date)
        if end_date:
            query = query.filter(JournalEntry.date <= end_date)

        result = query.with_entities(func.avg(JournalEntry.stress_level)).scalar()
        return float(result) if result is not None else None

    def __repr__(self):
        return f"<User(id={self.id}, age={self.age}, gender={self.gender}, height={self.height}, weight={self.weight})>"
