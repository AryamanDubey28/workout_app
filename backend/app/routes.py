from flask import current_app as app, jsonify, request
from .models import Workout, Exercise as ExerciseModel, User
from .services import generate_random_workout, add_exercise
from . import db
from sqlalchemy import select
from datetime import date
from firebase_admin import auth as firebase_auth


def verify_firebase_token():
    """Verify Firebase ID token from the request header."""
    auth_header = request.headers.get('Authorization')

    if not auth_header or not auth_header.startswith('Bearer '):
        return None

    id_token = auth_header.split('Bearer ')[1]

    try:
        decoded_token = firebase_auth.verify_id_token(id_token)
        return decoded_token['uid']  # Firebase UID
    except Exception as e:
        print(f"Error verifying Firebase ID token: {e}")
        return None

@app.route('/user', methods=['POST'])
def create_user():
    uid = verify_firebase_token()
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    user_data = request.json
    new_user = User(
        id=uid,  # Use Firebase UID as the user ID
        age=user_data['age'],
        gender=user_data['gender'],
        height=user_data['height'],
        weight=user_data['weight']
    )
    db.session.add(new_user)
    db.session.commit()
    return jsonify({"message": "User created successfully", "user_id": new_user.id}), 201

@app.route('/user/<string:user_id>', methods=['PUT'])
def update_user(user_id):
    uid = verify_firebase_token()
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    if uid != user_id:
        return jsonify({"error": "Unauthorized"}), 403

    user = User.query.get_or_404(user_id)
    user_data = request.json
    user.age = user_data.get('age', user.age)
    user.gender = user_data.get('gender', user.gender)
    user.height = user_data.get('height', user.height)
    user.weight = user_data.get('weight', user.weight)
    user.steps_taken = user_data.get('steps_taken', user.steps_taken)
    user.worked_out_today = user_data.get('worked_out_today', user.worked_out_today)

    db.session.commit()
    return jsonify({"message": "User updated successfully"}), 200

@app.route('/user/<string:user_id>/log_run', methods=['POST'])
def log_run(user_id):
    uid = verify_firebase_token()
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    if uid != user_id:
        return jsonify({"error": "Unauthorized"}), 403

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

@app.route('/workout', methods=['GET'])
def get_workout():
    uid = verify_firebase_token()  # Verify the ID token from the Authorization header
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    today = date.today()
    workout = db.session.execute(select(Workout).filter_by(date=today, user_id=uid)).scalar_one_or_none()
    if workout:
        response = {
            "pushup": workout.pushup,
            "pullup": workout.pullup,
            "squat_lunge": workout.squat
        }
    else:
        response = generate_random_workout(user_id=uid)
        workout = Workout(
            user_id=uid,  # Associate the workout with the authenticated user
            date=today,
            pushup=response["pushup"],
            pullup=response["pullup"],
            squat=response["squat_lunge"]
        )
        db.session.add(workout)
        db.session.commit()
    return jsonify(response)


@app.route('/exercises', methods=['GET'])
def get_exercises():
    uid = verify_firebase_token()  # Verify the ID token from the Authorization header
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    user_exercises = ExerciseModel.query.filter_by(user_id=uid).all()  # Fetch exercises for the authenticated user
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



@app.route('/add_exercise', methods=['POST'])
def add_exercise_route():
    uid = verify_firebase_token()  # Verify the ID token from the Authorization header
    if not uid:
        return jsonify({"error": "Unauthorized"}), 401

    exercise_data = request.json
    print(f"Received exercise data = {exercise_data}")
    if 'name' not in exercise_data or 'musclesWorked' not in exercise_data:
        return jsonify({"error": "Invalid input"}), 400

    result = add_exercise(exercise_data)
    print(f"Added exercise! data={exercise_data}")
    return jsonify(result), 201


@app.route('/')
def home():
    return "Welcome to the Workout API!"