import 'package:flutter/material.dart';
import '../services/fake_service.dart';

class AsyncDemoPage extends StatefulWidget {
  const AsyncDemoPage({super.key});

  @override
  State<AsyncDemoPage> createState() => _AsyncDemoPageState();
}

class _AsyncDemoPageState extends State<AsyncDemoPage> {
  Map<String, dynamic>? _data;
  String? _error;
  bool _loading = false;

  Future<void> _load({bool fail = false}) async {
    setState(() {
      _loading = true;
      _error = null;
      _data = null;
    });
    print('[AsyncDemo] antes de await');
    try {
      final result = await FakeService.fetchData(
        delay: const Duration(seconds: 3),
        shouldFail: fail,
      );
      print('[AsyncDemo] después de await con éxito');
      if (!mounted) return;
      setState(() {
        _data = result;
      });
    } catch (e) {
      print('[AsyncDemo] después de await con error: $e');
      if (!mounted) return;
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
      print('[AsyncDemo] finally - limpieza/fin de proceso');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Async/Await + Future')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _loading ? null : () => _load(),
                  icon: const Icon(Icons.downloading),
                  label: const Text('Cargar'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _loading ? null : () => _load(fail: true),
                  icon: const Icon(Icons.error_outline),
                  label: const Text('Forzar error'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_loading) ...[
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),
              const Center(child: Text('Cargando…')),
            ] else if (_error != null) ...[
              Text('Error: $_error', style: const TextStyle(color: Colors.red)),
            ] else if (_data != null) ...[
              const Text('Éxito:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_data.toString()),
            ] else ...[
              const Text('Presiona "Cargar" para iniciar la petición'),
            ],
            const SizedBox(height: 20),
            const Text(
              'Revisa la consola para ver el orden de ejecución: antes, durante y después.',
              style: TextStyle(fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}
