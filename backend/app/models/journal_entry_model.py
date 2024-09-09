from .. import db
from sqlalchemy import String, Integer, DateTime, ForeignKey, Index, Text
from sqlalchemy.orm import mapped_column
from datetime import datetime

class JournalEntry(db.Model):
    __tablename__ = "journal_entries"
    id = mapped_column(Integer, primary_key=True)
    user_id = mapped_column(String, ForeignKey('users.id'), nullable=False)
    date = mapped_column(DateTime, nullable=False, default=datetime.utcnow)
    stress_level = mapped_column(Integer, nullable=False)
    content = mapped_column(Text, nullable=False)

    __table_args__ = (
        Index('idx_user_date', 'user_id', 'date'),
    )

    def __repr__(self):
        return f"<JournalEntry(id={self.id}, user_id={self.user_id}, date={self.date}, stress_level={self.stress_level})>"