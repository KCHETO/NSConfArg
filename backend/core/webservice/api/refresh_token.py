import datetime
import flask

from core.common.decorators import validation_token_required
from core.common.authorization_helper import (validate_token,
                                              extract_bearer_token)
from core.model.token import Token

api = flask.Blueprint('nsconf.tokens', __name__)


@api.route('', methods=['POST'])
@validation_token_required(validate_token)
def refresh_token():
    access_token = extract_bearer_token()
    Token.objects(access_token=access_token).update(set__revoked=True)

    new_token = Token(
        expire_in=datetime.datetime.now() + datetime.timedelta(seconds=40)
    )
    new_token.save()

    return flask.jsonify({
        'access_token': new_token.access_token,
        'expire_in': new_token.expire_in.isoformat()
    })


