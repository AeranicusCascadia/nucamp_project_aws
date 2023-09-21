from flask import Blueprint, jsonify, abort, request
from ..models import Listing, Member, Feature, Reservation, db


bp = Blueprint('reservations', __name__, url_prefix='/reservations')


@bp.route('', methods=['GET'])  # decorator takes path and list of HTTP verbs
def index():
    reservations = Reservation.query.all()  # ORM performs SELECT query
    result = []
    for r in reservations:
        result.append(r.serialize())  # build list of members as dictionaries
    return jsonify(result)  # return JSON response


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    r = Reservation.query.get_or_404(id)
    return jsonify(r.serialize())


@bp.route('', methods=['POST'])
def create():

    # construct reservation
    r = Reservation(
        listing_id=request.json['listing_id'],
        date=request.json['date'],
        sites_reserved=request.json['sites_reserved']
    )

    db.session.add(r)  # prepare CREATE statement
    db.session.commit()  # execute CREATE statement
    return jsonify(r.serialize())
