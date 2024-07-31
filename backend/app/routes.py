from flask import current_app as app, jsonify
from .models import Workout
from .services import generate_random_workout
from . import db
from sqlalchemy import select
from datetime import date

@app.route('/workout', methods=['GET'])
def get_workout():
    today = date.today()
    workout = db.session.execute(select(Workout).filter_by(date=today)).scalar_one_or_none()
    if workout:
        response = {
            "pushup": workout.pushup,
            "pullup": workout.pullup,
            "squat_lunge": workout.squat
        }
        print(f"Workout exists in database already -> {response}")
    else:
        random_workout = generate_random_workout()
        print(f"workout does not exist, saving {random_workout}")
        workout = Workout(
            date=today,
            pushup=random_workout["pushup"],
            pullup=random_workout["pullup"],
            squat=random_workout["squat_lunge"]
        )
        # type: ignore
        db.session.add(workout)
        db.session.commit()
        response = random_workout
        print(f"response = {jsonify(response)}")
    return jsonify(response)

@app.route('/')
def home():
    return "Welcome to the Workout API!"