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

    def json(self):
        return {
            'name': self.name,
            'image_url': self.image,
            'category': self.category
        }