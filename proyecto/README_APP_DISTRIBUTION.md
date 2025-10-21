# Taller: Firebase App Distribution

Objetivo: subir y distribuir el APK de la app usando Firebase App Distribution y documentar el proceso con evidencias.

---

## Resumen del flujo

1. Preparar la app y generar APK de release.
2. Crear/abrir el proyecto en Firebase Console y registrar la app Android.
3. Configurar App Distribution: crear grupo `QA_Clase`, agregar tester `dduran@uceva.edu.co`.
4. Subir APK (recomendado `app-release.apk`) a App Distribution con Release Notes.
5. Distribuir al grupo y verificar instalación/actualización.

---

## 1) Preparación del APK

- Generar build de release (desde la raíz del repo):

```powershell
flutter clean; flutter pub get; flutter build apk --release
```

- El APK se generará en:

```
build/app/outputs/flutter-apk/app-release.apk
```

- Verificar permisos en `android/app/src/main/AndroidManifest.xml` (ej. `<uses-permission android:name="android.permission.INTERNET"/>`).

- Versionado (asegurar incremento para actualizaciones):

  - En `android/app/build.gradle` comprobar `versionName` y `versionCode`.
  - Alternativamente gestionar `version` en `pubspec.yaml` (ej.: `version: 1.0.1+2`).

Recomendación: antes de subir, renombrar el APK con la versión: `app-1.0.1.apk`.

---

## 2) Configurar Firebase App Distribution

1. Abrir Firebase Console (https://console.firebase.google.com) y seleccionar el proyecto.
2. Añadir app Android:
   - Package name: usar `applicationId` de `android/app/build.gradle`.
   - Descargar `google-services.json` si es necesario y añadir a `android/app/` (no es estrictamente necesario solo para App Distribution, pero común).
3. En la sección "App Distribution" → "Testers & groups" crear un grupo llamado `QA_Clase`.
4. Agregar tester `dduran@uceva.edu.co` al grupo (o directamente como tester individual).
5. Ir a "Releases" → "Distribute" → subir `app-release.apk`.
6. Completar Release Notes (ver plantilla abajo), asignar al grupo `QA_Clase` y distribuir.
7. Copiar enlace de instalación proporcionado por Firebase (se puede pegar en el PDF de evidencias).

### Plantilla de Release Notes (ejemplo)

```
Versión: 1.0.1
Fecha: 2025-10-20
Cambios:
- Añadido listado de recetas y pantalla de detalle
- Corrección de navegación y manejo de errores
Credenciales/Notas de prueba:
- Usuario: test@example.com / contraseña: 123456 (si aplica)
Responsable: Juan Perez
```

---

## 3) Evidencias requeridas (PDF final)

El PDF debe contener (mínimo):

- Portada: URL del repositorio y ramas relevantes (dev, main, feature/app_distribution).
- Captura del panel "Releases" mostrando la versión y nombre del archivo APK.
- Captura del panel "Testers & groups" con `dduran@uceva.edu.co` visible.
- Captura del correo de invitación recibido por un tester o captura del enlace de instalación.
- Foto o captura de la app instalada en un dispositivo Android abierta (pantalla de inicio de la app).
- Evidencia de actualización (antes: versión 1.0.0, después: 1.0.1) — capturas del panel antes/después o del dispositivo.
- Bitácora de QA (máx. 1 página): tabla con versión, fecha, cambios, incidencias encontradas y estado (resuelta/pendiente).

---

## 4) Checklist de verificación

- [ ] APK generado en `build/app/outputs/flutter-apk/app-release.apk`
- [ ] `INTERNET` permission en AndroidManifest si aplica
- [ ] Incremento de versión (versionName/versionCode)
- [ ] Proyecto y app Android registrados en Firebase
- [ ] Grupo `QA_Clase` creado y tester `dduran@uceva.edu.co` agregado
- [ ] Release subido y asignado al grupo
- [ ] Tester puede instalar vía correo/enlace
- [ ] Capturas y bitácora listas en PDF

---

## 5) Pasos rápidos para replicar en el equipo

1. Clonar repo y crear rama (opcional):

```powershell
git checkout dev
git pull
git checkout -b feature/app_distribution
```

2. Generar release y renombrar APK:

```powershell
flutter clean; flutter pub get; flutter build apk --release
copy .\build\app\outputs\flutter-apk\app-release.apk .\app-1.0.1.apk
```

3. Subir APK en Firebase Console → App Distribution → Releases → Distribute.

4. Añadir testers en Testers & groups → QA_Clase → invite dduran@uceva.edu.co.

---

## 6) Notas sobre versionado y formato de Release Notes

- Usar `version: x.y.z+build` en `pubspec.yaml` para llevar control (ej.: `1.0.1+2`).
- `versionName` = `x.y.z`, `versionCode` = integer incrementado para Android.
- Release Notes: siempre incluir `Versión`, `Fecha`, `Cambios` y `Responsable`.

---

Si quieres, puedo:

- Crear la rama `feature/app_distribution` desde `dev` y preparar los comandos de build en un script.
- Generar un ejemplo de PDF con placeholders y plantilla de bitácora.
- Guiarte paso a paso al subir el APK y tomar las capturas necesarias.

Indica qué prefieres que haga ahora y lo hago (crear rama, script de build, o plantilla de PDF). 
