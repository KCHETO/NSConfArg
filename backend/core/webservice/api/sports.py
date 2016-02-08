import flask

from core.common.decorators import validation_token_required
from core.common.authorization_helper import validate_token
from core.model.sports import Sport

api = flask.Blueprint('nsconf.sports', __name__)


@api.route('')
@validation_token_required(validate_token)
def list_of_sports():
    sports = map(lambda x: x.json(), Sport.objects())
    return flask.jsonify({'sports': sports})
