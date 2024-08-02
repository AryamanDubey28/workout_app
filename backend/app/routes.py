from flask import current_app as app, jsonify,request
from .models import Workout, Exercise as ExerciseModel
from .services import generate_random_workout, add_exercise
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