import flask

from flask_mongoengine import MongoEngine
from core.webservice.api import login as login_ws
from core.webservice.api import sports as sports_ws


def create_app():
    app = flask.Flask(__name__)

    # MongoDB Database configuration
    app.config['MONGODB_SETTINGS'] = {
        'db': 'nsconfarg'
    }

    @app.before_first_request
    def init_database():
        MongoEngine(app=app)

    app.register_blueprint(login_ws.api, url_prefix='/login')
    app.register_blueprint(sports_ws.api, url_prefix='/sports')

    return app
