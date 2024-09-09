from app.models.exercise_model import Exercise as ExerciseModel
from app import db
from .workout_service import Exercise, exercises

def add_exercise(exercise_data, user_id):
    exercise = Exercise(
        name=exercise_data['name'],
        muscles_worked=exercise_data['musclesWorked'],
        weight=exercise_data.get('weight', None)
    )
    category = exercise.categorize()

    # Add exercise to the in-memory list for quick access
    exercises[category].append(exercise)
    print(f"Added exercise to in-code list {exercise}")

    # Save the exercise to the database
    exercise_model = ExerciseModel(
        user_id=user_id,
        name=exercise.name,
        muscles_worked=",".join(exercise.muscles_worked),
        weight=exercise.weight
    )
    db.session.add(exercise_model)
    db.session.commit()
    print(f"Saved {exercise.name} to DB")

    return {
        "message": f"Exercise {exercise.name} added to {category} list.",
        "id": exercise_model.id
    }

def get_exercises(user_id):
    user_exercises = ExerciseModel.query.filter_by(user_id=user_id).all()
    exercises_list = [
        {
            "id": exercise.id,
            "name": exercise.name,
            "musclesWorked": exercise.muscles_worked.split(','),
            "weight": exercise.weight
        }
        for exercise in user_exercises
    ]
    return exercises_list