from flask_mongoengine import Document
from mongoengine import (StringField,
                         BooleanField)
from werkzeug.security import gen_salt


class Token(Document):
    access_token = StringField(required=True, default=gen_salt(30))
    revoked = BooleanField(required=True, default=False)

    meta = {
        'collection': 'tokens'
    }
