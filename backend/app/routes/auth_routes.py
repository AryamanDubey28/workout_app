from flask import Blueprint, jsonify, request
from app.utils.auth import verify_firebase_token, generate_random_user_id
from app.models.user_model import User
from app import db


bp = Blueprint('auth', __name__, url_prefix='/auth')

@bp.route('/user', methods=['POST'])
def create_user():
    uid = verify_firebase_token()
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401
    # uid = generate_random_user_id()
    # print(f"generated {uid}")

    existing_user = User.query.get(uid)
    if existing_user:
        return jsonify({"error": "User already exists"}), 409

    user_data = request.json
    required_fields = ['age', 'email', 'user_name', 'gender', 'height', 'weight']

    # Check if all required fields are present and non-empty
    for field in required_fields:
        if not user_data.get(field):
            return jsonify({"error": f"Field '{field}' is missing or empty"}), 400

    try:
        new_user = User(
        id=uid,  # Use the Firebase UID as the user ID
        age=user_data.get('age'),
        email = user_data.get('email'),
        user_name =user_data.get('user_name'),
        gender=user_data.get('gender'),
        height=user_data.get('height'),
        weight=user_data.get('weight')
        )
        db.session.add(new_user)
        db.session.commit()
    except:
        return jsonify({"message": "Error creating user"}), 500
    return jsonify({"message": "User created successfully", "user_id": new_user.id}), 201