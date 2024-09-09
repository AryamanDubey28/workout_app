from flask import request
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
