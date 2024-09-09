## app/routes/exercise.py
from flask import Blueprint, jsonify, request
from app.utils.auth import verify_firebase_token
from app.models.exercise_model import Exercise
from app.services.exercise_service import add_exercise


bp = Blueprint('exercise', __name__, url_prefix='/exercise')

@bp.route('', methods=['GET'])
def get_exercises():
    uid = verify_firebase_token()
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    user_exercises = Exercise.query.filter_by(user_id=uid).all()
    exercises_list = [
        {
            "id": exercise.id,
            "name": exercise.name,
            "musclesWorked": exercise.muscles_worked.split(','),
            "weight": exercise.weight
        }
        for exercise in user_exercises
    ]
    return jsonify(exercises_list)

@bp.route('', methods=['POST'])
def add_exercise_route():
    uid = verify_firebase_token()
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    exercise_data = request.json
    if 'name' not in exercise_data or 'musclesWorked' not in exercise_data:
        return jsonify({"error": "Invalid input"}), 400

    result = add_exercise(exercise_data, uid)
    return jsonify(result), 201
