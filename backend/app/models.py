from . import db
from sqlalchemy import String, Integer, Date, Float, Boolean, DateTime, ForeignKey, Index, Text, func
from sqlalchemy.orm import mapped_column
from datetime import datetime, date, timedelta

#
# class Workout(db.Model):
#     __tablename__ = "workouts"
#     id = mapped_column(Integer, primary_key=True)
#     date = mapped_column(Date, nullable=False, unique=True)
#     pushup = mapped_column(String(80), nullable=False)
#     pullup = mapped_column(String(80), nullable=False)
#     squat = mapped_column(String(80), nullable=False)
#
#     def __repr__(self):
#         return f"<Workout(id={self.id}, date={self.date}, pushup={self.pushup}, pullup={self.pullup}, squat={self.squat})>"


# class Exercise(db.Model):
#     __tablename__ = "exercises"
#     id = mapped_column(Integer, primary_key=True)
#     user_id = mapped_column(String, ForeignKey('users.id'), nullable=False)
#     name = mapped_column(String(80), nullable=False)
#     muscles_worked = mapped_column(String(255), nullable=False)  # store as comma-separated string
#     weight = mapped_column(Float, nullable=True)
#
#     def __repr__(self):
#         return f"<Exercise(id={self.id}, name={self.name}, muscles_worked={self.muscles_worked}, weight={self.weight})>"


# class User(db.Model):
#     __tablename__ = "users"
#     id = mapped_column(Integer, primary_key=True)
#     age = mapped_column(Integer, nullable=False)
#     gender = mapped_column(String(10), nullable=False)
#     height = mapped_column(Float, nullable=False)  # in centimeters
#     weight = mapped_column(Float, nullable=False)  # in kilograms
#     steps_taken = mapped_column(Integer, default=0)
#     worked_out_today = mapped_column(Boolean, default=False)
#     streak = db.Column(db.Integer, default=0)
#     last_workout_date = db.Column(db.Date, nullable=True)
#     last_run = mapped_column(DateTime, nullable=True)
#
#     def update_streak(self):
#         """Updates user's streak of working out"""
#         today = date.today()
#         if self.last_workout_date == today:
#             return  # No need to update streak if it's already done for today
#
#         if self.last_workout_date == today - timedelta(days=1):
#             self.streak += 1  # Continue the streak
#         else:
#             self.streak = 1  # Reset streak
#
#         self.last_workout_date = today
#         self.worked_out_today = True
#
#     def log_run(self, distance_km, time_minutes):
#         """Logs a run and calculates calories burned based on distance or time."""
#         calories_burned = self.calculate_calories_burned(distance_km, time_minutes)
#         self.worked_out_today = True
#         self.last_run = datetime.now()
#         return calories_burned
#
#     def calculate_calories_burned(self, distance_km, time_minutes):
#         """Simple formula to calculate calories burned."""
#         MET = 9.8  # Metabolic equivalent for running (~9.8 METs for 8 km/h)
#         weight_kg = self.weight
#
#         # Calories burned = MET * weight_kg * time_hours
#         time_hours = time_minutes / 60
#         calories_burned = MET * weight_kg * time_hours
#
#         # Adjust calories based on distance as a secondary factor
#         calories_burned += 0.75 * weight_kg * distance_km  # Adjust multiplier as needed
#         return calories_burned
#
#     def get_stress_level_history(self, start_date=None, end_date=None):
#         """
#         Retrieves the stress level history for the user.
#
#         :param start_date: Optional start date for the history (inclusive)
#         :param end_date: Optional end date for the history (inclusive)
#         :return: List of tuples (date, stress_level)
#         """
#         query = JournalEntry.query.filter_by(user_id=self.id).order_by(JournalEntry.date)
#
#         if start_date:
#             query = query.filter(JournalEntry.date >= start_date)
#         if end_date:
#             query = query.filter(JournalEntry.date <= end_date)
#
#         return [(entry.date, entry.stress_level) for entry in query.all()]
#
#     def get_average_stress_level(self, start_date=None, end_date=None):
#         """
#         Calculates the average stress level for the user.
#
#         :param start_date: Optional start date for the calculation (inclusive)
#         :param end_date: Optional end date for the calculation (inclusive)
#         :return: Average stress level or None if no entries
#         """
#         query = JournalEntry.query.filter_by(user_id=self.id)
#
#         if start_date:
#             query = query.filter(JournalEntry.date >= start_date)
#         if end_date:
#             query = query.filter(JournalEntry.date <= end_date)
#
#         result = query.with_entities(func.avg(JournalEntry.stress_level)).scalar()
#         return float(result) if result is not None else None
#
#     def __repr__(self):
#         return f"<User(id={self.id}, age={self.age}, gender={self.gender}, height={self.height}, weight={self.weight})>"


# class DailySteps(db.Model):
#     __tablename__ = "daily_steps"
#     id = mapped_column(Integer, primary_key=True)
#     user_id = mapped_column(String, ForeignKey('users.id'), nullable=False)
#     date = mapped_column(Date, nullable=False)
#     steps = mapped_column(Integer, nullable=False)
#
#     __table_args__ = (
#         Index('idx_user_date', 'user_id', 'date'),
#     )
#
#     def __repr__(self):
#         return f"<DailySteps(user_id={self.user_id}, date={self.date}, steps={self.steps})>"

#
# class JournalEntry(db.Model):
#     __tablename__ = "journal_entries"
#     id = mapped_column(Integer, primary_key=True)
#     user_id = mapped_column(String, ForeignKey('users.id'), nullable=False)
#     date = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
#     stress_level = mapped_column(Integer, nullable=False)
#     content = mapped_column(Text, nullable=False)
#
#     __table_args__ = (
#         Index('idx_user_date', 'user_id', 'date'),
#     )
#
#     def __repr__(self):
#         return f"<JournalEntry(id={self.id}, user_id={self.user_id}, date={self.date}, stress_level={self.stress_level})>"