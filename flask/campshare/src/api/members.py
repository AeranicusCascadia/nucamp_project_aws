from flask import Blueprint, jsonify, abort, request
from ..models import Listing, Member, Feature, Reservation, db

import hashlib
import secrets


def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()


bp = Blueprint('members', __name__, url_prefix='/members')


@bp.route('', methods=['GET'])  # decorator takes path and list of HTTP verbs
def index():
    members = Member.query.all()  # ORM performs SELECT query
    result = []
    for m in members:
        result.append(m.serialize())  # build list of Tweets as dictionaries
    return jsonify(result)  # return JSON response


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    m = Member.query.get_or_404(id)
    return jsonify(m.serialize())


@bp.route('', methods=['POST'])
def create():
    # req body must contain username and password
    if 'username' not in request.json or 'password' not in request.json:
        return abort(400)

    if (len(request.json['username']) < 3) or (len(request.json['password']) < 8):
        return abort(400)

    # construct User
    m = Member(

        username=request.json['username'],
        password=scramble(request.json['password'])
    )
    db.session.add(m)  # prepare CREATE statement
    db.session.commit()  # execute CREATE statement
    return jsonify(m.serialize())

# modify this


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    m = Member.query.get_or_404(id)
    try:
        db.session.delete(m)  # prepare DELETE statement
        db.session.commit()  # execute DELETE statement
        return jsonify(True)
    except:
        # something went wrong :(
        return jsonify(False)


@bp.route('/<int:id>', methods=['PATCH', 'PUT'])
def update(id: int):
    m = Member.query.get_or_404(id)

    if ('username' not in request.json) and ('password' not in request.json):
        return abort(400)

    if 'username' in request.json:
        m.username = request.json['username']
        if len(request.json['username']) < 3:
            return abort(400)

    if 'password' in request.json:
        m.password = scramble(request.json['password'])
        if len(request.json['password']) < 8:
            return abort(400)
    try:
        db.session.commit()
        return jsonify(m.serialize())
    except:
        return jsonify(False)
