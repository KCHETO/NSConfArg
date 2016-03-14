import datetime
import flask
import logging

from core.model.token import Token
from webargs import (flaskparser, fields)

api = flask.Blueprint('nsconf.login', __name__)
logger = logging.getLogger('webservices.api.login')


@api.route('', methods=['POST'])
@flaskparser.use_args({
    'username': fields.Str(required=True),
    'password': fields.Str(required=True)
})
def login(args):
    username = args['username']
    password = args['password']

    if username == 'nsconfarg' and password == 'password':
        token = Token(
            expire_in=datetime.datetime.now() + datetime.timedelta(seconds=40)
        ).save()
        json = {
            'access_token': token.access_token,
            'expire_in': token.expire_in.isoformat(),
            'name': 'NSConf-Argentina',
            'image_url': 'http://nsconfarg.com/img/nsconfarg@2x.png'
        }
        return flask.jsonify(json)

    res = flask.jsonify({'error_msg': 'Invalid Credentials'})
    res.status_code = 401
    return res
