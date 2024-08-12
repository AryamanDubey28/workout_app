from flask import current_app as app, jsonify,request
from .models import Workout, Exercise as ExerciseModel, User
from .services import generate_random_workout, add_exercise
from . import db
from sqlalchemy import select
from datetime import date


@app.route('/user', methods=['POST'])
def create_user():
    user_data = request.json
    new_user = User(
        age=user_data['age'],
        gender=user_data['gender'],
        height=user_data['height'],
        weight=user_data['weight']
    )
    db.session.add(new_user)
    db.session.commit()
    return jsonify({"message": "User created successfully", "user_id": new_user.id}), 201


@app.route('/user/<int:user_id>', methods=['PUT'])
def update_user(user_id):
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


@app.route('/user/<int:user_id>/log_run', methods=['POST'])
def log_run(user_id):
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

@app.route('/exercises', methods=['GET'])
def get_exercises():
    all_exercises = ExerciseModel.query.all()
    exercises_list = [
        {
            "id": exercise.id,
            "name": exercise.name,
            "musclesWorked": exercise.muscles_worked.split(','),
            "weight": exercise.weight
        }
        for exercise in all_exercises
    ]
    return jsonify(exercises_list)


@app.route('/add_exercise', methods=['POST'])
def add_exercise_route():
    exercise_data = request.json
    print(f"Recieved exercise data = {exercise_data}")
    if 'name' not in exercise_data or 'musclesWorked' not in exercise_data:
        return jsonify({"error": "Invalid input"}), 400

    result = add_exercise(exercise_data)
    print(f"added exercise! data={exercise_data}")
    return jsonify(result), 201

@app.route('/')
def home():
    return "Welcome to the Workout API!"