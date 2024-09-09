from .. import db
from sqlalchemy import String, Integer, Date, ForeignKey, Index
from sqlalchemy.orm import mapped_column


class DailySteps(db.Model):
    __tablename__ = "daily_steps"
    id = mapped_column(Integer, primary_key=True)
    user_id = mapped_column(String, ForeignKey('users.id'), nullable=False)
    date = mapped_column(Date, nullable=False)
    steps = mapped_column(Integer, nullable=False)

    __table_args__ = (
        Index('idx_user_date', 'user_id', 'date'),
    )

    def __repr__(self):
        return f"<DailySteps(user_id={self.user_id}, date={self.date}, steps={self.steps})>"
