from flask_mongoengine import Document
from mongoengine import (StringField,
                         URLField)


class Sport(Document):
    name = StringField(required=True)
    image = URLField(required=True)
    category = StringField(required=True)

    meta = {
        'collection': 'sports'
    }