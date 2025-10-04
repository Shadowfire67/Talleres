# Evidencias - Taller Segundo Plano

Primera página
- URL del repositorio: https://github.com/Shadowfire67/Talleres
- Ramas involucradas: main, dev, feature/taller_segundo_plano

## 1) Future / async / await
- Captura 1: Estado "Cargando…" en `AsyncDemoPage`.
- Captura 2: Estado "Éxito" mostrando el mapa de datos.
- Captura 3: Estado "Error" tras usar "Forzar error".
- Consola: pega un fragmento con el orden de ejecución (antes, durante, después).

## 2) Timer (cronómetro)
- Captura 1: Tiempo corriendo tras "Iniciar".
- Captura 2: "Pausar" mostrando el tiempo detenido.
- Captura 3: "Reanudar" y/o "Reiniciar" (tiempo en 00:00:00).

## 3) Isolate (tarea pesada)
- Captura 1: Pantalla mostrando "Procesando en isolate…".
- Captura 2: Resultado con suma 1..N y tiempo en ms.
- Consola: logs si corresponde.

## Notas para el revisor
- Código clave:
  - `lib/services/fake_service.dart` – Servicio simulado con Future.delayed.
  - `lib/screens/async_demo_page.dart` – Estados de carga con async/await.
  - `lib/screens/timer_demo_page.dart` – Cronómetro con Timer y limpieza en dispose.
  - `lib/screens/isolate_demo_page.dart` – Cálculo CPU-bound en Isolate.
  - `lib/main.dart` – Menú y navegación entre demos.

## Cómo reproducir
1) flutter pub get
2) flutter run
3) Probar las tres pantallas desde el menú.
