import flask
import logging

from mongoengine import Q
from core.model.token import Token

logger = logging.getLogger("decorators")


def extract_bearer_token():
    auth_header = flask.request.headers.get('Authorization')

    if auth_header is None:
        logger.warn("Authorization header missing from request")
        return None

    auth = auth_header.split()

    if len(auth) != 2 or auth[0] != 'Bearer':
        logger.warn("Authorization header format not recognized: '%s'" % auth_header)
        return None

    return auth[1]


def validate_token(token):
    db_token = Token.objects(Q(access_token=token) & Q(revoked=False)).first()
    return True if db_token is not None else False
