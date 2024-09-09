from flask import Blueprint, jsonify, request
from app.utils.auth import verify_firebase_token
from app.models.user_model import User
from app import db

bp = Blueprint('user', __name__, url_prefix='/user')

@bp.route('/<string:user_id>', methods=['PUT'])
def update_user(user_id):
    uid = verify_firebase_token()
    if not uid or uid != user_id:
        return jsonify({"error": "Unauthorized"}), 401

    user = User.query.get_or_404(user_id)
    user_data = request.json
    user.age = user_data.get('age', user.age)
    user.email = user_data.get('email', user.email)
    user.user_name = user_data.get('user_name',user.user_name)
    user.gender = user_data.get('gender', user.gender)
    user.height = user_data.get('height', user.height)
    user.weight = user_data.get('weight', user.weight)
    user.steps_taken = user_data.get('steps_taken', user.steps_taken)
    user.worked_out_today = user_data.get('worked_out_today', user.worked_out_today)

    db.session.commit()
    return jsonify({"message": "User updated successfully"}), 200

@bp.route('/<string:user_id>/log_run', methods=['POST'])
def log_run(user_id):
    uid = verify_firebase_token()
    if not uid or uid != user_id:
        return jsonify({"error": "Unauthorized"}), 401

    user = User.query.get_or_404(user_id)
    run_data = request.json
    distance_km = run_data.get('distance_km')
    time_minutes = run_data.get('time_minutes')

    calories_burned = user.log_run(distance_km, time_minutes)
    db.session.commit()

    return jsonify({
        "message": "Run logged successfully",
        "calories_burned": calories_burned,
        "worked_out_today": user.worked_out_today
    }), 200

@bp.route('/<string:user_id>/update_workout_status', methods=['PUT'])
def update_workout_status(user_id):
    uid = verify_firebase_token()
    if not uid or uid != user_id:
        return jsonify({"error": "Unauthorized"}), 401

    user = User.query.get_or_404(user_id)
    user.worked_out_today = True
    user.update_streak()
    db.session.commit()

    return jsonify({
        "message": "Workout status updated successfully",
        "worked_out_today": user.worked_out_today,
        "streak": user.streak
    }), 200


@bp.route('/<string:user_id>/streak', methods=['GET'])
def get_streak(user_id):
    uid = verify_firebase_token()
    if not uid or uid != user_id:
        return jsonify({"error": "Unauthorized"}), 401

    user = User.query.get_or_404(user_id)

    return jsonify({
        "streak": user.streak
    }), 200