# Pelis Info

Aplicacion Flutter para descubrir peliculas a traves de The Movie Database (TMDB), consultar sus detalles y reparto, buscar titulos y conservar una lista de favoritas en almacenamiento local.

## Funcionalidades

- Consulta de peliculas en cartelera, populares, proximos estrenos y mejor calificadas.
- Carrusel de peliculas en cartelera.
- Carga paginada al desplazarse horizontalmente por cada listado.
- Busqueda de peliculas por titulo.
- Vista de detalle de pelicula con reparto.
- Marcado y desmarcado de peliculas favoritas.
- Persistencia local de favoritas mediante SQLite y Drift.
- Splash screen e iconos nativos configurados para Android e iOS.

## Tecnologias

- Flutter y Dart para la aplicacion multiplataforma.
- Riverpod para inyeccion de dependencias y manejo de estado.
- GoRouter para navegacion declarativa.
- Dio para peticiones HTTP a TMDB.
- Drift y `drift_flutter` para persistencia local.
- `flutter_dotenv` para cargar la clave de TMDB desde `.env`.
- `animate_do`, `card_swiper` y `flutter_staggered_grid_view` para componentes de interfaz.
- `build_runner` y `drift_dev` para generacion de codigo de Drift.

## Versiones

El proyecto se actualizo y se valido con las siguientes versiones del entorno:

| Herramienta | Version |
| --- | --- |
| Flutter | 3.47.1 |
| Dart | 3.13.1 |
| Canal | stable |

La restriccion de SDK del proyecto es `^3.13.1`.

### Dependencias principales resueltas

| Dependencia | Version |
| --- | --- |
| `flutter_riverpod` | 3.4.2 |
| `go_router` | 18.0.0 |
| `dio` | 5.11.0 |
| `drift` | 2.34.3 |
| `drift_flutter` | 0.3.1 |
| `flutter_dotenv` | 6.0.1 |
| `flutter_native_splash` | 2.4.8 |
| `flutter_launcher_icons` | 0.14.4 |
| `path_provider` | 2.1.6 |
| `intl` | 0.20.3 |
| `animate_do` | 5.1.0 |
| `card_swiper` | 3.0.1 |
| `flutter_staggered_grid_view` | 0.7.0 |
| `build_runner` | 2.16.0 |
| `drift_dev` | 2.34.5 |
| `flutter_lints` | 6.0.0 |

Las restricciones declaradas estan en [pubspec.yaml](pubspec.yaml); las versiones efectivamente resueltas estan bloqueadas en [pubspec.lock](pubspec.lock).

## Arquitectura

El codigo se organiza siguiendo una separacion de responsabilidades inspirada en Clean Architecture:

```text
lib/
├── config/           Configuracion compartida: entorno, router, tema, Drift y utilidades.
├── domain/           Entidades y contratos abstractos de datasources y repositories.
├── infrastructure/   Implementaciones de acceso a TMDB, Drift, modelos JSON y mappers.
├── presentation/     Pantallas, vistas, widgets, delegados y providers de Riverpod.
└── main.dart         Inicializacion de Flutter, .env, splash y ProviderScope.
```

El flujo de datos para peliculas es `presentation -> repository -> datasource`. Los datasources de TMDB convierten modelos JSON en entidades de dominio mediante mappers. El datasource de Drift implementa la persistencia de favoritas.

### Estado y navegacion

- `ProviderScope` envuelve la aplicacion en [lib/main.dart](lib/main.dart).
- Los providers de peliculas, reparto, busqueda y favoritas se encuentran en [lib/presentation/providers](lib/presentation/providers).
- La carga paginada usa `NotifierProvider` y `Notifier`; `StateProvider` conserva el texto de busqueda.
- [lib/config/router/app_router.dart](lib/config/router/app_router.dart) define un `ShellRoute` para la pantalla principal y las rutas `/`, `/movie/:id`, `/categories` y `/favorites`.

## TMDB y clave de API

La aplicacion consume la API v3 de TMDB en `https://api.themoviedb.org/3`. Se utiliza para los listados de peliculas, busqueda, detalle y creditos de reparto. Las solicitudes se realizan con idioma `es-CO`.

Antes de ejecutar la aplicacion, crea un archivo `.env` en la raiz del proyecto:

```env
THE_MOVIEDB_KEY=tu_clave_de_api_de_tmdb
```

Obtiene una clave desde [TMDB](https://www.themoviedb.org/settings/api). No publiques una clave real ni la incluyas en commits. El archivo `.env` esta declarado como asset en [pubspec.yaml](pubspec.yaml), por lo que debe existir localmente antes de iniciar la aplicacion.

## Requisitos

- Flutter 3.47.1 con Dart 3.13.1.
- Git.
- Para Android: Android SDK y una instalacion de Java compatible con Android Studio.
- Para iOS/macOS: macOS con Xcode.
- Una clave valida de TMDB configurada en `.env`.

Los directorios de plataforma presentes en el proyecto son Android, iOS, web, macOS, Linux y Windows. La disponibilidad final de cada destino depende de las herramientas instaladas en la maquina de desarrollo.

## Inicio rapido

```bash
git clone https://github.com/juanes030/pelis_info.git
cd pelis_info
flutter pub get
```

Crea `.env` como se indica arriba y comprueba el entorno:

```bash
flutter doctor
flutter analyze
```

Lista los dispositivos disponibles y ejecuta la aplicacion en uno de ellos:

```bash
flutter devices
flutter run -d <device-id>
```

Para ejecutar en el simulador de iOS detectado como `iPhone 17`:

```bash
flutter run -d "iPhone 17"
```

## Generacion de codigo y recursos

Drift genera [lib/config/database/database.g.dart](lib/config/database/database.g.dart) a partir de [lib/config/database/database.dart](lib/config/database/database.dart). Vuelve a generar el archivo despues de modificar la definicion de tablas:

```bash
dart run build_runner build
```

Para regenerar recursos nativos desde la configuracion de [pubspec.yaml](pubspec.yaml):

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

## Configuracion nativa actual

- Android usa Gradle 9.1.0, Android Gradle Plugin 8.13.2 y Kotlin 2.2.21, configurados en `android/`.
- iOS usa la integracion de Swift Package Manager generada por Flutter. [ios/Runner.xcodeproj/project.pbxproj](ios/Runner.xcodeproj/project.pbxproj) referencia `FlutterGeneratedPluginSwiftPackage`.
- La referencia heredada a `Pods/Pods.xcodeproj` fue retirada de [ios/Runner.xcworkspace/contents.xcworkspacedata](ios/Runner.xcworkspace/contents.xcworkspacedata). No hay `Podfile`, `Podfile.lock` ni `Pods/` en `ios/`.

Si el repositorio se encuentra en una carpeta administrada por macOS File Provider, como `Documents`, los atributos extendidos pueden impedir que Xcode firme frameworks generados. Mantiene los artefactos de build fuera de esa ubicacion o mueve el repositorio a un directorio local no administrado. Este proyecto ignora el enlace local `build` para permitir esa configuracion sin versionar los artefactos.

## Cambios de la actualizacion

La actualizacion a Flutter 3.47.1 incluyo:

- Actualizacion de la restriccion de Dart a `^3.13.1` y de las dependencias compatibles indicadas arriba.
- Migracion de los providers basados en `StateNotifierProvider` a `NotifierProvider` y `Notifier`, conservando los flujos y metodos de carga existentes.
- Regeneracion del codigo de Drift con la version actual de `build_runner` y `drift_dev`.
- Actualizacion de Gradle, Android Gradle Plugin y Kotlin para compatibilidad con Flutter 3.47.1 y el JDK disponible.
- Verificacion de la integracion iOS con Swift Package Manager y eliminacion de la referencia heredada de CocoaPods en el workspace.

## Validacion

Los comandos de mantenimiento habituales son:

```bash
flutter clean
flutter pub get
dart run build_runner build
flutter analyze
flutter test
flutter build apk --debug
flutter build ios --simulator
```

Actualmente el repositorio no contiene un directorio `test/`, por lo que `flutter test` no encuentra pruebas para ejecutar hasta que se agreguen.

## Build de producción Android

Para generar el Android App Bundle (`.aab`) de producción con ofuscación y reducción de código:

```bash
flutter build appbundle --release --obfuscate --split-debug-info=build/symbols

## Firebase App Distribution

Para generar un APK de release para distribuir mediante Firebase App Distribution:

```bash
flutter build apk --release

firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
  --app 1:514787778368:android:1604f8a158ebbc559364a5 \
  --groups pelisinfo-testers