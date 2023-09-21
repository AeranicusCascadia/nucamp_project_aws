import datetime
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# docker exec pg_container pg_dump campshare > campshare.sql
# yoyo migrations
# database = postgresql://postgres@localhost/campshare

# MY CAMPSHARE CODE


class Listing(db.Model):
    __tablename__ = 'listings'
    listing_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    listing_title = db.Column(db.String(128), unique=True, nullable=False)
    member_id = db.Column(db.Integer, nullable=False)

    def serialize(self):
        return {
            'listing_id': self.listing_id,
            'listing_title': self.listing_title
        }


class Member(db.Model):
    __tablename__ = 'members'
    member_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(128), unique=True, nullable=False)
    password = db.Column(db.String(128), nullable=False)

    def __init__(self, username: str, password: str):
        self.username = username
        self.password = password

    def serialize(self):
        return {
            'member_id': self.member_id,
            'username': self.username
        }


class Feature(db.Model):
    __tablename__ = 'features'
    feature_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    hosted = db.Column(db.Boolean)
    electricity = db.Column(db.Boolean)
    water = db.Column(db.Boolean)
    pets_allowed = db.Column(db.Boolean)
    listing_id = db.Column(db.Integer, nullable=False)

    def serialize(self):
        return {
            'feature_id': self.feature_id,
            'hosted': self.hosted,
            'electricity': self.electricity,
            'water': self.water,
            'pets_allowed': self.pets_allowed
        }


class Reservation(db.Model):
    __tablename__ = 'reservations'
    reservation_id = db.Column(
        db.Integer, primary_key=True, autoincrement=True)
    date = db.Column(db.Date, nullable=False)
    sites_remaining = db.Column(db.Integer)
    sites_reserved = db.Column(db.Integer, nullable=False)
    listing_id = db.Column(db.Integer, nullable=False)

    def serialize(self):
        return {
            'reservation_id': self.reservation_id,
            'date': self.date,
            'sites_remaining': self.sites_remaining,
            'sites_reserved': self.sites_reserved
        }

# ORIGINAL CODE FROM TWITTER CLONE


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(128), unique=True, nullable=False)
    password = db.Column(db.String(128), nullable=False)

    tweets = db.relationship('Tweet', backref='user', cascade="all,delete")

    def __init__(self, username: str, password: str):
        self.username = username
        self.password = password

    # User serialize

    def serialize(self):
        return {
            'id': self.id,
            'username': self.username
        }


likes_table = db.Table(
    'likes',
    db.Column(
        'user_id', db.Integer,
        db.ForeignKey('users.id'),
        primary_key=True
    ),

    db.Column(
        'tweet_id', db.Integer,
        db.ForeignKey('tweets.id'),
        primary_key=True
    ),

    db.Column(
        'created_at', db.DateTime,
        default=datetime.datetime.utcnow,
        nullable=False
    )
)


class Tweet(db.Model):
    __tablename__ = 'tweets'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    content = db.Column(db.String(280), nullable=False)
    created_at = db.Column(
        db.DateTime,
        default=datetime.datetime.utcnow,
        nullable=False
    )
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)

    # likes?
    liking_users = db.relationship(
        'User', secondary=likes_table,
        lazy='subquery',
        backref=db.backref('liked_tweets', lazy=True)
    )

    def __init__(self, content: str, user_id: int):
        self.content = content
        self.user_id = user_id

    def serialize(self):
        return {
            'id': self.id,
            'content': self.content,
            'created_at': self.created_at.isoformat(),
            'user_id': self.user_id
        }
