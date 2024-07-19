from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()

# def create_app():
#     app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///./workouts.db'
#