import datetime
from flask_mongoengine import Document
from mongoengine import (StringField,
                         BooleanField, DateTimeField)
from werkzeug.security import gen_salt


class Token(Document):
    access_token = StringField(required=True, default=gen_salt(30))
    expire_in = DateTimeField(required=True, default=datetime.datetime.now)
    revoked = BooleanField(required=True, default=False)

    meta = {
        'collection': 'tokens'
    }
