from flask import Blueprint, jsonify, request
from app.utils.auth import verify_firebase_token
from app.models.workout_model import Workout
from app.services.workout_service import generate_random_workout
from app import db
from datetime import date

bp = Blueprint('workout', __name__, url_prefix='/workout')

@bp.route('', methods=['GET'])
def get_workout():
    uid = verify_firebase_token()
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    today = date.today()
    workout = Workout.query.filter_by(date=today, user_id=uid).first()
    if workout:
        response = {
            "pushup": workout.pushup,
            "pullup": workout.pullup,
            "squat_lunge": workout.squat
        }
    else:
        response = generate_random_workout(user_id=uid)
        workout = Workout(
            user_id=uid,
            date=today,
            pushup=response["pushup"],
            pullup=response["pullup"],
            squat=response["squat_lunge"]
        )
        db.session.add(workout)
        db.session.commit()
    return jsonify(response)