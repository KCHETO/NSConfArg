import flask
import logging

from webargs import (flaskparser, fields)
from werkzeug.security import gen_salt

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
        json = {
            'access_token': gen_salt(40),
            'name': 'NSConf-Argentina',
            'image_url': 'http://nsconfarg.com/img/nsconfarg@2x.png'
        }
        return flask.jsonify(json)

    res = flask.jsonify({'error_msg': 'Invalid Credentials'})
    res.status_code = 401
    return res
