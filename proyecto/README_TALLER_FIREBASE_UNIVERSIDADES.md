# Taller: Firebase + Firestore (Universidades)

Este módulo integra Firebase (Firestore) en la app y gestiona la colección `universidades` con los campos:

- nit (string)
- nombre (string)
- direccion (string)
- telefono (string)
- pagina_web (string, URL)

Incluye:
- Inicialización de Firebase en `main.dart`.
- Servicio `UniversidadService` con stream en tiempo real y creación.
- Pantallas: listado en tiempo real y formulario con validación.
- Rutas con `go_router` (inicio en `/`, creación en `/universidades/nueva`).

## 1) Configuración de Firebase en el proyecto

Requisitos instalados: cuenta de Firebase, Flutter SDK, Dart, y opcionalmente FlutterFire CLI.

Pasos sugeridos (opción FlutterFire CLI):
1. Inicia sesión en Firebase y crea un proyecto (por ejemplo, `talleres-xxxx`).
2. En la carpeta del proyecto Flutter, ejecuta:
   ```powershell
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   - Selecciona el proyecto Firebase
   - Plataformas: Android, iOS, Web (y Desktop si deseas)
   - Esto genera `lib/firebase_options.dart` y configura la app Web.
3. Android/iOS: la CLI agrega los plugins necesarios. Si configuras manualmente:
   - Android: coloca `google-services.json` en `android/app/` y aplica el plugin `com.google.gms.google-services` en `android/app/build.gradle.kts` (ver documentación oficial, ya que aplicar el plugin sin el JSON puede romper el build).
   - iOS: `GoogleService-Info.plist` en `ios/Runner/`.
   - Web: la CLI inyecta el `firebaseConfig` en `web/index.html`.

Sin CLI (manual): sigue la guía oficial de Firebase Flutter para cada plataforma y asegúrate de llamar `Firebase.initializeApp()` en el arranque.

## 2) Estructura implementada

- `lib/main.dart`: inicializa Firebase y levanta `MaterialApp.router` con `appRouter`.
- `lib/config/app_router.dart`: rutas
  - `/` -> `UniversidadesListPage`
  - `/universidades/nueva` -> `UniversidadFormPage`
- `lib/models/universidad.dart`: modelo simple con `toMap()` y `fromDoc()`.
- `lib/services/universidad_service.dart`:
  - `streamUniversidades()` -> `Stream<List<Universidad>>`
  - `addUniversidad(Universidad)` -> `Future<void>`
  - `deleteById/updateById` de apoyo
- `lib/views/universidad_list_page.dart`: listview en tiempo real, eliminar documento y FAB para crear.
- `lib/views/universidad_form_page.dart`: formulario con validaciones básicas (campos requeridos y URL válida).

## 3) Validaciones
- Todos los campos obligatorios.
- `pagina_web` debe ser URL con `http://` o `https://`.

## 4) Cómo correr
- Desktop (Windows) o Android/iOS. En Web, asegúrate de que el `firebaseConfig` esté en `web/index.html` (FlutterFire CLI lo añade).
- Primer arranque puede requerir `flutter pub get`.
- Si aparece un error de inicialización, revisa la configuración de cada plataforma (JSON/PLIST/Config web).

## 5) Evidencias solicitadas (para el PDF)
- Captura de la consola Firebase y del proyecto configurado.
- Captura de la colección `universidades` con documentos y campos.
- Capturas de la app:
  - Listado en tiempo real mostrando los datos.
  - Formulario creando una nueva universidad y el listado actualizándose.
- Breve nota técnica: arquitectura (service + views + router), estado manejado con `StreamBuilder`, y validaciones en el `Form`.

## 6) PR y ramas
- Rama base: `dev`.
- Rama de trabajo: `feature/taller_firebase_universidades`.
- PR: `feature/taller_firebase_universidades` → `dev`.

> Nota: la app compila sin los archivos de credenciales, pero para ejecutar y conectar Firestore debes completar la configuración (CLI o manual). Evitamos aplicar el plugin `google-services` directamente para no romper la build cuando falten los archivos.