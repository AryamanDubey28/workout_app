from flask import request
from firebase_admin import auth as firebase_auth
import string,random,time


def generate_random_user_id():
    """
    Generates a random user ID similar to Firebase's user IDs.

    Firebase user IDs are strings of 28 characters that include:
    - Lowercase letters (a-z)
    - Uppercase letters (A-Z)
    - Numbers (0-9)
    - Hyphens (-)


    USE FOR TESTING!!
    """
    # Characters to choose from
    characters = string.ascii_letters + string.digits + '-'

    # Generate a 28-character string
    user_id = ''.join(random.choice(characters) for _ in range(28))

    # Ensure the ID is unique by appending a timestamp
    timestamp = str(int(time.time() * 1000))[-4:]  # Last 4 digits of current timestamp

    # Replace the last 4 characters with the timestamp
    user_id = user_id[:24] + timestamp

    return user_id


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
