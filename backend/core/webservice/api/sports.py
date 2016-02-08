import flask

from core.model.sports import Sport
from webargs import (flaskparser, fields)

api = flask.Blueprint('nsconf.sports', __name__)


@api.route('')
def list_of_sports():
    sports = map(lambda x: x.json(), Sport.objects())
    return flask.jsonify({'sports': sports})
