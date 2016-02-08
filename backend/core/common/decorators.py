import functools
import flask
from core.common.authorization_helper import extract_bearer_token


def validation_token_required(validator_func, *validator_func_params):

    def proxy(func):
        @functools.wraps(func)
        def decorator(*args, **kwargs):
            token_is_valid = validator_func(extract_bearer_token(), *validator_func_params)

            if not token_is_valid:
                res = flask.jsonify({'error_msg': 'Unauthorized'})
                res.status_code = 401
                return res

            return func(*args, **kwargs)
        return decorator

    return proxy
