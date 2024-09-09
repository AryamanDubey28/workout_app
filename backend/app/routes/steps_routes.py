from flask import Blueprint, jsonify, request
from app.utils.auth import verify_firebase_token
from app.models.daily_steps_model import DailySteps
from app import db
from datetime import datetime

bp = Blueprint('steps', __name__, url_prefix='/steps')

@bp.route('/<string:user_id>', methods=['POST'])
def add_or_update_steps(user_id):
    uid = verify_firebase_token()
    if not uid or uid != user_id:
        return jsonify({"error": "Unauthorized"}), 401

    data = request.json
    date_str = data.get('date')
    steps = data.get('steps')

    if not date_str or steps is None:
        return jsonify({"error": "Invalid input"}), 400

    date = datetime.strptime(date_str, "%Y-%m-%d").date()
    daily_steps = DailySteps.query.filter_by(user_id=user_id, date=date).first()

    if daily_steps:
        daily_steps.steps = steps  # Update if exists
    else:
        daily_steps = DailySteps(user_id=user_id, date=date, steps=steps)
        db.session.add(daily_steps)

    db.session.commit()
    return jsonify({"message": "Steps added/updated successfully"}), 200

@bp.route('/<string:user_id>', methods=['GET'])
def get_steps_history(user_id):
    uid = verify_firebase_token()
    if not uid or uid != user_id:
        return jsonify({"error": "Unauthorized"}), 401

    steps_history = DailySteps.query.filter_by(user_id=user_id).order_by(DailySteps.date.desc()).all()
    history_list = [{"date": step.date.strftime("%Y-%m-%d"), "steps": step.steps} for step in steps_history]

    return jsonify(history_list), 200
