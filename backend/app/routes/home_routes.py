from flask import Blueprint

bp = Blueprint('home', __name__, url_prefix='/')

@bp.route('/')
def home():
    return "Welcome to Thrive Health API"