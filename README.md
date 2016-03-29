# NSOperations
NSConfArg 2016 - NSOperations a Fondo

## Introducción

Este proyecto es una demo acerca de como usar NSOperations utilizando el ejemplo de Apple de [Advanced NSOperations (WWDC15)](https://developer.apple.com/videos/play/wwdc2015/226/) para la [NSConfArg](http://nsconfarg.com/).

Este proyecto esta compuesto de un *Backend* y una aplicación *iOS* como cliente.

### Backend

Este proyecto utiliza un pequeño y simple backend hecho en *Python*. Este server utiliza:

- Python 2.7
- [Virtualenv](https://virtualenv.pypa.io/en/latest/)
- [Flask](http://flask.pocoo.org/)
- [MongDB](https://www.mongodb.org/)

Para correr el proyecto se deben seguir estos pasos:

```
> cd backend
> . venv/bin/activate
> source env.sh
> python -m "core.runner"
```

Para insertar datos de prueba, hay un archivo que genera una lista de datos. Ejecutar `python mock_db.py` despues de levantar el server de *mongodb*.

### Client

La aplicación esta desarrollada con **Swift 2.2** y **Xcode 7.3**. Como manejador de dependencias utiliza [Carthage](https://github.com/Carthage/Carthage). Las dependencias que utiliza son:

- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [Realm](https://realm.io)

Para correr la aplicación, hay que ejecutar

```
> cd client/PhotoList
> carthage update --no-use-binaries --platform iOS
> open PhotoList.xcodeproj
```

