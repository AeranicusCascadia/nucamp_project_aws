from flask import Blueprint, jsonify, abort, request
from ..models import Listing, Member, Feature, Reservation, db

bp = Blueprint('features', __name__, url_prefix='/features')


@bp.route('', methods=['GET'])  # decorator takes path and list of HTTP verbs
def index():
    features = Feature.query.all()  # ORM performs SELECT query
    result = []
    for f in features:
        result.append(f.serialize())  # build list of members as dictionaries
    return jsonify(result)  # return JSON response


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    f = Feature.query.get_or_404(id)
    return jsonify(f.serialize())


@bp.route('', methods=['POST'])
def create():
    f = Feature(
        hosted=request.json['hosted'],
        electricity=request.json['electricity'],
        water=request.json['water'],
        pets_allowed=request.json['pets_allowed'],
        listing_id=request.json['listing_id']
    )

    db.session.add(f)  # prepare CREATE statement
    db.session.commit()  # execute CREATE statement
    return jsonify(f.serialize())
