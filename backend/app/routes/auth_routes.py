from flask import Blueprint, jsonify, request
from app.utils.auth import verify_firebase_token
from app.models.user_model import User
from app import db

bp = Blueprint('auth', __name__, url_prefix='/auth')

@bp.route('/user', methods=['POST'])
def create_user():
    uid = verify_firebase_token()
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    user_data = request.json
    new_user = User(
        id=uid,
        age=user_data['age'],
        gender=user_data['gender'],
        height=user_data['height'],
        weight=user_data['weight']
    )
    db.session.add(new_user)
    db.session.commit()
    return jsonify({"message": "User created successfully", "user_id": new_user.id}), 201