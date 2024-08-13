from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from firebase_admin import credentials, initialize_app

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config.Config')

    db.init_app(app)

    # Initialize Firebase Admin SDK
    cred = credentials.Certificate("account_key/workouttracker-39078-firebase-adminsdk-ybc16-f1d8cdc248.json")
    initialize_app(cred)

    with app.app_context():
        from . import routes
        db.create_all()

    return app