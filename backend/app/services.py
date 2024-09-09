
# import random
# from .models import Exercise as ExerciseModel
# from . import db
#
# class Exercise:
#     def __init__(self, name, muscles_worked, weight=None):
#         self.name = name
#         self.muscles_worked = muscles_worked
#         self.weight = weight
#
#     def categorize(self):
#         # Categorize based on muscle groups
#         if any(muscle in self.muscles_worked for muscle in ['Back', 'Biceps', 'Forearms']):
#             return "pullup"
#         elif any(muscle in self.muscles_worked for muscle in ['Chest', 'Triceps', 'Shoulders']):
#             return "pushup"
#         elif any(muscle in self.muscles_worked for muscle in ['Quads', 'Hamstrings', 'Calves']):
#             return "squat_lunge"
#         elif "Abs" in self.muscles_worked:
#             return "core"
#         return "other"
#
# # Lists to store exercises
# exercises = {
#     "pushup": [
#         Exercise("Deficit Pushup", ["Chest", "Triceps", "Shoulders"]),
#         Exercise("3 Sec Paused Pushups", ["Chest", "Triceps", "Shoulders"]),
#         Exercise("Diamond Pushup", ["Chest", "Triceps", "Shoulders"]),
#         Exercise("Decline Pushup", ["Chest", "Triceps", "Shoulders"]),
#         Exercise("Ring Pushup", ["Chest", "Triceps", "Shoulders"]),
#         Exercise("Counter Top Dips", ["Chest", "Triceps", "Shoulders"]),
#         Exercise("Clap Pushup", ["Chest", "Triceps", "Shoulders"]),
#     ],
#     "pullup": [
#         Exercise("Standard Pull-Up", ["Back", "Biceps", "Forearms"]),
#         Exercise("Chin-Up", ["Back", "Biceps", "Forearms"]),
#         Exercise("Wide Grip Pull-Up", ["Back", "Biceps", "Forearms"]),
#         Exercise("Close Grip Chin-Up", ["Back", "Biceps", "Forearms"]),
#         Exercise("Commando Pull-Up", ["Back", "Biceps", "Forearms"]),
#         Exercise("Ring Pull-Up", ["Back", "Biceps", "Forearms"]),
#         Exercise("Ring Rows", ["Back", "Biceps", "Forearms"]),
#         Exercise("Wide Grip Chin-Up", ["Back", "Biceps", "Forearms"]),
#         Exercise("3 Sec Paused Pull-Up", ["Back", "Biceps", "Forearms"]),
#         Exercise("3 Sec Paused Chin-Up", ["Back", "Biceps", "Forearms"]),
#     ],
#     "squat_lunge": [
#         Exercise("Heel Elevated Squat", ["Quads", "Hamstrings", "Calves"]),
#         Exercise("Jump Squat", ["Quads", "Hamstrings", "Calves"]),
#         Exercise("5 Sec Paused Heel Elevated Squat", ["Quads", "Hamstrings", "Calves"]),
#         Exercise("Bulgarian Split Squat", ["Quads", "Hamstrings", "Calves"]),
#         Exercise("Walking Lunge", ["Quads", "Hamstrings", "Calves"]),
#     ],
#     "core": [
#         # Placeholder for core exercises; can add default exercises if needed
#     ],
#     "other": [
#         # Placeholder for exercises that don't fit into the above categories
#     ],
# }
#
# def generate_random_workout(user_id):
#     # Fetch user-defined exercises from the database
#     user_exercises = ExerciseModel.query.filter_by(user_id=user_id).all()
#
#     # Combine predefined and user-defined exercises
#     combined_exercises = {
#         "pushup": exercises["pushup"][:],
#         "pullup": exercises["pullup"][:],
#         "squat_lunge": exercises["squat_lunge"][:],
#         "core": exercises["core"][:],
#         "other": exercises["other"][:]
#     }
#
#     for exercise in user_exercises:
#         categorized = Exercise(
#             name=exercise.name,
#             muscles_worked=exercise.muscles_worked.split(','),
#             weight=exercise.weight
#         )
#         category = categorized.categorize()
#         combined_exercises[category].append(categorized)
#
#     # Select random exercises from the combined lists
#     print(f"Combined list pushups = {combined_exercises['pushup']}")
#     pushup = random.choice(combined_exercises["pushup"])
#     pullup = random.choice(combined_exercises["pullup"])
#     squat_lunge = random.choice(combined_exercises["squat_lunge"])
#
#     return {
#         "pushup": pushup.name,
#         "pullup": pullup.name,
#         "squat_lunge": squat_lunge.name
#     }
#
# def add_exercise(exercise_data):
#     exercise = Exercise(
#         name=exercise_data['name'],
#         muscles_worked=exercise_data['musclesWorked'],
#         weight=exercise_data.get('weight', None)
#     )
#     category = exercise.categorize()
#
#     # Add exercise to the in-memory list for quick access
#     exercises[category].append(exercise)
#     print(f"Added exercise to in code list {exercise}")
#     # Save the exercise to the database
#     exercise_model = ExerciseModel(
#         name=exercise.name,
#         muscles_worked=",".join(exercise.muscles_worked),
#         weight=exercise.weight
#     )
#     db.session.add(exercise_model)
#     db.session.commit()
#     print(f"Saved {exercise.name} to DB")
#
#     return {
#         "message": f"Exercise {exercise.name} added to {category} list."
#     }