from flask import Blueprint, jsonify, abort, request
from ..models import Listing, Member, Feature, Reservation, db

bp = Blueprint('listings', __name__, url_prefix='/listings')

# INDEX


@bp.route('', methods=['GET'])  # decorator takes path and list of HTTP verbs
def index():
    listings = Listing.query.all()  # ORM performs SELECT query
    result = []
    for l in listings:
        result.append(l.serialize())  # build list of Tweets as dictionaries
    return jsonify(result)  # return JSON response

# SHOW


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    l = Listing.query.get_or_404(id)
    return jsonify(l.serialize())

# CREATE


@bp.route('', methods=['POST'])
def create():
    l = Listing(
        listing_title=request.json['title'],
        member_id=request.json['member_id']
    )

    if 'member_id' not in request.json:
        return abort(400)

    db.session.add(l)  # prepare CREATE statement
    db.session.commit()  # execute CREATE statement
    return jsonify(l.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    l = Listing.query.get_or_404(id)
    try:
        db.session.delete(l)  # prepare DELETE statement
        db.session.commit()  # execute DELETE statement
        return jsonify(True)
    except:
        # something went wrong :(
        return jsonify(False)
