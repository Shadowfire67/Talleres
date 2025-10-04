import 'dart:async';
import 'package:flutter/material.dart';

class TimerDemoPage extends StatefulWidget {
  const TimerDemoPage({super.key});

  @override
  State<TimerDemoPage> createState() => _TimerDemoPageState();
}

class _TimerDemoPageState extends State<TimerDemoPage> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _running = false;

  void _start() {
    if (_running) return;
    _running = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsed += const Duration(seconds: 1);
      });
    });
  }

  void _pause() {
    if (!_running) return;
    _running = false;
    _timer?.cancel();
  }

  void _resume() {
    if (_running) return;
    _start();
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _running = false;
      _elapsed = Duration.zero;
    });
  }

  String _format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = two(d.inHours);
    final m = two(d.inMinutes.remainder(60));
    final s = two(d.inSeconds.remainder(60));
    return '$h:$m:$s';
  }

  @override
  void dispose() {
    // Limpieza de recursos al salir de la vista
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer / Cronómetro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _format(_elapsed),
              style: const TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _start,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Iniciar'),
                ),
                OutlinedButton.icon(
                  onPressed: _pause,
                  icon: const Icon(Icons.pause),
                  label: const Text('Pausar'),
                ),
                OutlinedButton.icon(
                  onPressed: _resume,
                  icon: const Icon(Icons.play_circle),
                  label: const Text('Reanudar'),
                ),
                TextButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reiniciar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
