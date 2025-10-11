# Taller: Segundo plano en Flutter (Future, Timer, Isolate)

Este repo contiene la implementación de tres demos para trabajar procesos de segundo plano en Flutter:

1) Future + async/await: simulación de carga remota con `Future.delayed`, mostrando estados Cargando/Éxito/Error.
2) Timer: cronómetro con Iniciar/Pausar/Reanudar/Reiniciar, actualización cada 1 s y limpieza en `dispose`.
3) Isolate: tarea CPU-bound (suma 1..N) ejecutada en un `Isolate.spawn`, comunicando resultados por mensajes.

## Estructura relevante

- `lib/main.dart`: menú principal para navegar a cada demo.
- `lib/services/fake_service.dart`: servicio simulado con `Future.delayed`.
- `lib/screens/async_demo_page.dart`: demo de Future/async/await.
- `lib/screens/timer_demo_page.dart`: demo de Timer (cronómetro).
- `lib/screens/isolate_demo_page.dart`: demo de Isolate (tarea pesada).

## ¿Cuándo usar cada uno?

- Future / async / await:
	- Operaciones asíncronas no-bloqueantes que esperan I/O: red, lectura de archivos, delays.
	- Usa `await` para escribir código secuencial y manejar errores con `try/catch`.
	- Muestra estados en la UI (cargando, error, datos) para buena UX.

- Timer:
	- Tareas basadas en tiempo (repetición o una sola vez) en el hilo principal.
	- Ej.: cronómetro/contador, sondeos simples. Cancela el `Timer` al pausar o salir (`dispose`).

- Isolate:
	- Trabajo pesado de CPU que bloquearía la UI si se ejecuta en el hilo principal.
	- Usa `Isolate.spawn` y comunica datos por `SendPort/ReceivePort`.
	- Ideal para cálculos intensivos, parseos grandes, compresión, etc.

## Pantallas y flujos

- Menú principal (`HomeMenuPage`):
	- 1) Future + async/await → `AsyncDemoPage`
		- Botones: Cargar / Forzar error.
		- Estados: Cargando… (CircularProgressIndicator), Éxito (datos), Error.
		- Consola: impresión del orden de ejecución (antes, durante, después).
	- 2) Timer → `TimerDemoPage`
		- Botones: Iniciar / Pausar / Reanudar / Reiniciar.
		- Texto grande con el tiempo formateado HH:MM:SS.
		- Limpieza: `dispose` cancela el timer.
	- 3) Isolate → `IsolateDemoPage`
		- Input N; ejecuta suma 1..N en un isolate y devuelve resultado y tiempo (ms).
		- Muestra progreso y libera el isolate al terminar o salir.

## Cómo ejecutar

1. Tener Flutter configurado.
2. Instalar dependencias:
	 - `flutter pub get`
3. Ejecutar:
	 - `flutter run`

## GitFlow utilizado

- Rama base: `dev`. Se creó la rama `feature/taller_segundo_plano` para el taller.
- Se abrirá PR de `feature/taller_segundo_plano` → `dev`. Tras revisión, merge a `dev` y luego integrar a `main`.

## Evidencias

Incluye en el PDF:
- Cronómetro/contador funcionando (iniciar/pausar/reiniciar).
- Pantalla de carga (Future/async/await) y resultado.
- Isolate: pantalla con tiempos y consola con mensajes.
- Primera página: URL del repositorio.

