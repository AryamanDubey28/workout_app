











# from flask import current_app as app, jsonify, request
# from .models import Workout, Exercise as ExerciseModel, User, DailySteps, JournalEntry
# from .services import generate_random_workout, add_exercise
# from . import db
# from sqlalchemy import select
# from datetime import date, datetime
# from firebase_admin import auth as firebase_auth
#
#
# def verify_firebase_token():
#     """Verify Firebase ID token from the request header."""
#     auth_header = request.headers.get('Authorization')
#
#     if not auth_header or not auth_header.startswith('Bearer '):
#         return None
#
#     id_token = auth_header.split('Bearer ')[1]
#
#     try:
#         decoded_token = firebase_auth.verify_id_token(id_token)
#         return decoded_token['uid']  # Firebase UID
#     except Exception as e:
#         print(f"Error verifying Firebase ID token: {e}")
#         return None
#
# @app.route('/user', methods=['POST'])
# def create_user():
#     uid = verify_firebase_token()
#     if not uid:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     user_data = request.json
#     new_user = User(
#         id=uid,  # Use Firebase UID as the user ID
#         age=user_data['age'],
#         gender=user_data['gender'],
#         height=user_data['height'],
#         weight=user_data['weight']
#     )
#     db.session.add(new_user)
#     db.session.commit()
#     return jsonify({"message": "User created successfully", "user_id": new_user.id}), 201
#
# @app.route('/user/<string:user_id>', methods=['PUT'])
# def update_user(user_id):
#     uid = verify_firebase_token()
#     if not uid:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     if uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 403
#
#     user = User.query.get_or_404(user_id)
#     user_data = request.json
#     user.age = user_data.get('age', user.age)
#     user.gender = user_data.get('gender', user.gender)
#     user.height = user_data.get('height', user.height)
#     user.weight = user_data.get('weight', user.weight)
#     user.steps_taken = user_data.get('steps_taken', user.steps_taken)
#     user.worked_out_today = user_data.get('worked_out_today', user.worked_out_today)
#
#     db.session.commit()
#     return jsonify({"message": "User updated successfully"}), 200
#
# @app.route('/user/<string:user_id>/log_run', methods=['POST'])
# def log_run(user_id):
#     uid = verify_firebase_token()
#     if not uid:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     if uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 403
#
#     user = User.query.get_or_404(user_id)
#     run_data = request.json
#     distance_km = run_data.get('distance_km')
#     time_minutes = run_data.get('time_minutes')
#
#     calories_burned = user.log_run(distance_km, time_minutes)
#     db.session.commit()
#
#     return jsonify({
#         "message": "Run logged successfully",
#         "calories_burned": calories_burned,
#         "worked_out_today": user.worked_out_today
#     }), 200
#
# @app.route('/workout', methods=['GET'])
# def get_workout():
#     uid = verify_firebase_token()  # Verify the ID token from the Authorization header
#     if not uid:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     today = date.today()
#     workout = db.session.execute(select(Workout).filter_by(date=today, user_id=uid)).scalar_one_or_none()
#     if workout:
#         response = {
#             "pushup": workout.pushup,
#             "pullup": workout.pullup,
#             "squat_lunge": workout.squat
#         }
#     else:
#         response = generate_random_workout(user_id=uid)
#         workout = Workout(
#             user_id=uid,  # Associate the workout with the authenticated user
#             date=today,
#             pushup=response["pushup"],
#             pullup=response["pullup"],
#             squat=response["squat_lunge"]
#         )
#         db.session.add(workout)
#         db.session.commit()
#     return jsonify(response)
#
# @app.route('/user/<user_id>/update_workout_status', methods=['PUT'])
# def update_workout_status(user_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     data = request.json
#     worked_out_today = data.get('worked_out_today')
#
#     user = User.query.filter_by(id=user_id).first()
#     if not user:
#         return jsonify({"error": "User not found"}), 404
#
#     if worked_out_today:
#         user.update_streak()
#     else:
#         user.worked_out_today = False
#
#     db.session.commit()
#     return jsonify({"message": "Workout status and streak updated"}), 200
#
#
# @app.route('/user/<user_id>/streak', methods=['GET'])
# def get_streak(user_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     user = User.query.filter_by(id=user_id).first()
#     if not user:
#         return jsonify({"error": "User not found"}), 404
#
#     return jsonify({"streak": user.streak}), 200
#
#
# @app.route('/exercises', methods=['GET'])
# def get_exercises():
#     uid = verify_firebase_token()  # Verify the ID token from the Authorization header
#     if not uid:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     user_exercises = ExerciseModel.query.filter_by(user_id=uid).all()  # Fetch exercises for the authenticated user
#     exercises_list = [
#         {
#             "id": exercise.id,
#             "name": exercise.name,
#             "musclesWorked": exercise.muscles_worked.split(','),
#             "weight": exercise.weight
#         }
#         for exercise in user_exercises
#     ]
#     return jsonify(exercises_list)
#
#
#
# @app.route('/add_exercise', methods=['POST'])
# def add_exercise_route():
#     uid = verify_firebase_token()  # Verify the ID token from the Authorization header
#     if not uid:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     exercise_data = request.json
#     print(f"Received exercise data = {exercise_data}")
#     if 'name' not in exercise_data or 'musclesWorked' not in exercise_data:
#         return jsonify({"error": "Invalid input"}), 400
#
#     result = add_exercise(exercise_data)
#     print(f"Added exercise! data={exercise_data}")
#     return jsonify(result), 201
#
#
# @app.route('/user/<user_id>/steps', methods=['POST'])
# def add_or_update_steps(user_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     data = request.json
#     date_str = data.get('date')
#     steps = data.get('steps')
#
#     if not date_str or steps is None:
#         return jsonify({"error": "Invalid input"}), 400
#
#     date = datetime.strptime(date_str, "%Y-%m-%d").date()
#     daily_steps = DailySteps.query.filter_by(user_id=user_id, date=date).first()
#
#     if daily_steps:
#         daily_steps.steps = steps  # Update if exists
#     else:
#         daily_steps = DailySteps(user_id=user_id, date=date, steps=steps)
#         db.session.add(daily_steps)
#
#     db.session.commit()
#     return jsonify({"message": "Steps added/updated successfully"}), 200
#
# @app.route('/user/<user_id>/steps', methods=['GET'])
# def get_steps_history(user_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     steps_history = DailySteps.query.filter_by(user_id=user_id).order_by(DailySteps.date.desc()).all()
#     history_list = [{"date": step.date.strftime("%Y-%m-%d"), "steps": step.steps} for step in steps_history]
#
#     return jsonify(history_list), 200
#
#
# @app.route('/user/<string:user_id>/journal', methods=['POST'])
# def create_journal_entry(user_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     data = request.json
#     new_entry = JournalEntry(
#         user_id=user_id,
#         stress_level=data['stress_level'],
#         content=data['content']
#     )
#     db.session.add(new_entry)
#     db.session.commit()
#     return jsonify({"message": "Journal entry created", "id": new_entry.id}), 201
#
# @app.route('/user/<string:user_id>/journal', methods=['GET'])
# def get_journal_entries(user_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     entries = JournalEntry.query.filter_by(user_id=user_id).order_by(JournalEntry.date.desc()).all()
#     return jsonify([
#         {
#             "id": entry.id,
#             "date": entry.date.isoformat(),
#             "stress_level": entry.stress_level,
#             "content": entry.content
#         } for entry in entries
#     ]), 200
#
# @app.route('/user/<string:user_id>/journal/<int:entry_id>', methods=['GET'])
# def get_journal_entry(user_id, entry_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     entry = JournalEntry.query.filter_by(id=entry_id, user_id=user_id).first()
#     if not entry:
#         return jsonify({"error": "Entry not found"}), 404
#
#     return jsonify({
#         "id": entry.id,
#         "date": entry.date.isoformat(),
#         "stress_level": entry.stress_level,
#         "content": entry.content
#     }), 200
#
# @app.route('/user/<string:user_id>/journal/<int:entry_id>', methods=['PUT'])
# def update_journal_entry(user_id, entry_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     entry = JournalEntry.query.filter_by(id=entry_id, user_id=user_id).first()
#     if not entry:
#         return jsonify({"error": "Entry not found"}), 404
#
#     data = request.json
#     entry.stress_level = data.get('stress_level', entry.stress_level)
#     entry.content = data.get('content', entry.content)
#     db.session.commit()
#     return jsonify({"message": "Journal entry updated"}), 200
#
# @app.route('/user/<string:user_id>/journal/<int:entry_id>', methods=['DELETE'])
# def delete_journal_entry(user_id, entry_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     entry = JournalEntry.query.filter_by(id=entry_id, user_id=user_id).first()
#     if not entry:
#         return jsonify({"error": "Entry not found"}), 404
#
#     db.session.delete(entry)
#     db.session.commit()
#     return jsonify({"message": "Journal entry deleted"}), 200
#
# @app.route('/user/<string:user_id>/stress_history', methods=['GET'])
# def get_stress_history(user_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     user = User.query.get_or_404(user_id)
#
#     start_date = request.args.get('start_date')
#     end_date = request.args.get('end_date')
#
#     if start_date:
#         start_date = datetime.strptime(start_date, "%Y-%m-%d").date()
#     if end_date:
#         end_date = datetime.strptime(end_date, "%Y-%m-%d").date()
#
#     history = user.get_stress_level_history(start_date, end_date)
#     return jsonify([{"date": date.isoformat(), "stress_level": level} for date, level in history]), 200
#
# @app.route('/user/<string:user_id>/average_stress', methods=['GET'])
# def get_average_stress(user_id):
#     uid = verify_firebase_token()
#     if not uid or uid != user_id:
#         return jsonify({"error": "Unauthorized"}), 401
#
#     user = User.query.get_or_404(user_id)
#
#     start_date = request.args.get('start_date')
#     end_date = request.args.get('end_date')
#
#     if start_date:
#         start_date = datetime.strptime(start_date, "%Y-%m-%d").date()
#     if end_date:
#         end_date = datetime.strptime(end_date, "%Y-%m-%d").date()
#
#     avg_stress = user.get_average_stress_level(start_date, end_date)
#     return jsonify({"average_stress_level": avg_stress}), 200
#
# @app.route('/')
# def home():
#     return "Welcome to the Thrive HealthAPI!"
#





# Routes Files
