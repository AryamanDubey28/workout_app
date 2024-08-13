import json
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from firebase_admin import credentials, initialize_app

db = SQLAlchemy()


def create_app():
    app = Flask(__name__)
    app.config.from_object('app.config.Config')

    db.init_app(app)

    # Load the config file
    with open('config.json') as config_file:
        config = json.load(config_file)

    firebase_key_path = config.get('firebase_admin_key_path')
    if not firebase_key_path:
        raise ValueError("Firebase admin key path not set in config.json")

    # Initialize Firebase Admin SDK
    cred = credentials.Certificate(firebase_key_path)
    initialize_app(cred)

    with app.app_context():
        from . import routes
        db.create_all()

    return app