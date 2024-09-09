from flask import Blueprint, jsonify, request
from app.utils.auth import verify_firebase_token
from app.models.journal_entry_model import JournalEntry
from app import db
from datetime import datetime

bp = Blueprint('journal', __name__, url_prefix='/journal')

@bp.route('/<string:user_id>', methods=['POST'])
def create_journal_entry(user_id):
    uid = verify_firebase_token()
    if not uid or uid != user_id:
        return jsonify({"error": "Unauthorized"}), 401

    data = request.json
    new_entry = JournalEntry(
        user_id=user_id,
        stress_level=data['stress_level'],
        content=data['content']
    )
    db.session.add(new_entry)
    db.session.commit()
    return jsonify({"message": "Journal entry created", "id": new_entry.id}), 201

@bp.route('/<string:user_id>', methods=['GET'])
def get_journal_entries(user_id):
    uid = verify_firebase_token()
    if not uid or uid != user_id:
        return jsonify({"error": "Unauthorized"}), 401

    entries = JournalEntry.query.filter_by(user_id=user_id).order_by(JournalEntry.date.desc()).all()
    return jsonify([
        {
            "id": entry.id,
            "date": entry.date.isoformat(),
            "stress_level": entry.stress_level,
            "content": entry.content
        } for entry in entries
    ]), 200

@bp.route('/<string:user_id>/<int:entry_id>', methods=['GET', 'PUT', 'DELETE'])
def manage_journal_entry(user_id, entry_id):
    uid = verify_firebase_token()
    if not uid or uid != user_id:
        return jsonify({"error": "Unauthorized"}), 401

    entry = JournalEntry.query.filter_by(id=entry_id, user_id=user_id).first()
    if not entry:
        return jsonify({"error": "Entry not found"}), 404

    if request.method == 'GET':
        return jsonify({
            "id": entry.id,
            "date": entry.date.isoformat(),
            "stress_level": entry.stress_level,
            "content": entry.content
        }), 200

    elif request.method == 'PUT':
        data = request.json
        entry.stress_level = data.get('stress_level', entry.stress_level)
        entry.content = data.get('content', entry.content)
        db.session.commit()
        return jsonify({"message": "Journal entry updated"}), 200

    elif request.method == 'DELETE':
        db.session.delete(entry)
        db.session.commit()
        return jsonify({"message": "Journal entry deleted"}), 200
