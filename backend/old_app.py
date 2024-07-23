


#Works but monolithic


# from flask import Flask, jsonify
# from flask_sqlalchemy import SQLAlchemy
#
# from sqlalchemy import ForeignKey, insert, select
# from sqlalchemy import String, Integer, create_engine, Table, Column, Date
# from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship, Session
# import random
# from datetime import date
#
# app = Flask(__name__)
#
# # Configuration for SQLite database
# app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///./workouts.db'
# db = SQLAlchemy(app)
#
#
# # Define the Workout model
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
#
# # Create the database tables
# with app.app_context():
#     db.create_all()
#
# # Arrays of exercises
# pushup_exercises = [
#     "Deficit Pushup", "3 Sec Paused Pushups", "Diamond Pushup", "Decline Pushup", "Ring Pushup", "Counter Top Dips",
#     "Clap Pushup"
# ]
#
# pullup_exercises = [
#     "Standard Pull-Up", "Chin-Up", "Wide Grip Pull-Up", "Close Grip Chin-Up",
#     "Commando Pull-Up", "Ring Pull-Up", "Ring Rows", "Wide Grip Chin-Up", "3 Sec Paused Pull-Up", "3 Sec Paused Chin-Up"
# ]
#
# squat_lunge_exercises = [
#     "Heel Elevated Squat", "Jump Squat", "5 Sec Paused Heel Elevated Squat",
#     "Bulgarian Split Squat", "Walking Lunge"
# ]
#
# # Function to generate a random workout
# def generate_random_workout():
#     pushup = random.choice(pushup_exercises)
#     pullup = random.choice(pullup_exercises)
#     squat_lunge = random.choice(squat_lunge_exercises)
#     return {
#         "pushup": pushup,
#         "pullup": pullup,
#         "squat_lunge": squat_lunge
#     }
#
# @app.route('/workout', methods=['GET'])
# def get_workout():
#     today = date.today()
#     workout = db.session.execute(select(Workout).filter_by(date=today)).scalar_one_or_none()
#     if workout:
#         response = {
#             "pushup": workout.pushup,
#             "pullup": workout.pullup,
#             "squat_lunge": workout.squat
#         }
#         print(f"Workout exists in database already -> {response}")
#     else:
#         random_workout = generate_random_workout()
#         print(f"workout does not exist, saving {random_workout}")
#         workout = Workout(
#             date=today,
#             pushup=random_workout["pushup"],
#             pullup=random_workout["pullup"],
#             squat=random_workout["squat_lunge"]
#         ) # type: ignore
#         db.session.add(workout)
#         db.session.commit()
#         response = random_workout
#         print(f"response = {jsonify(response)}")
#     return jsonify(response)
#
# @app.route('/')
# def home():
#     return "Welcome to the Workout API!"
#
# if __name__ == '__main__':
#     app.run(debug=True)