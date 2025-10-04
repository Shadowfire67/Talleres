import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateDemoPage extends StatefulWidget {
  const IsolateDemoPage({super.key});

  @override
  State<IsolateDemoPage> createState() => _IsolateDemoPageState();
}

class _IsolateDemoPageState extends State<IsolateDemoPage> {
  bool _running = false;
  String? _result;
  String? _error;
  Isolate? _isolate;
  ReceivePort? _receivePort;
  late final TextEditingController _controller;

  static void _heavyTask(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final message in port) {
      if (message is int) {
        final n = message;
        final sw = Stopwatch()..start();
        // Tarea CPU-bound: suma de 1..n
        // Evitar overflow usando BigInt si n es grande
        BigInt sum = BigInt.zero;
        for (int i = 1; i <= n; i++) {
          sum += BigInt.from(i);
        }
        sw.stop();
        sendPort.send({'ok': true, 'sum': sum.toString(), 'ms': sw.elapsedMilliseconds});
      } else if (message == 'exit') {
        port.close();
        break;
      }
    }
  }

  Future<void> _startCompute(int n) async {
    if (_running) return;
    setState(() {
      _running = true;
      _result = null;
      _error = null;
    });

    final receive = ReceivePort();
    _receivePort = receive;
    _isolate = await Isolate.spawn(_heavyTask, receive.sendPort);

    late StreamSubscription sub;
    sub = receive.listen((message) async {
      if (message is SendPort) {
        // Canal listo: enviar trabajo
        message.send(n);
      } else if (message is Map) {
        if (!mounted) return;
        if (message['ok'] == true) {
          setState(() {
            _result = 'Suma 1..$n = ${message['sum']} (en ${message['ms']} ms)';
            _running = false;
          });
        } else {
          setState(() {
            _error = 'Fallo en isolate';
            _running = false;
          });
        }
        await sub.cancel();
        _disposeIsolate();
      }
    });
  }

  void _disposeIsolate() {
    _receivePort?.close();
    _receivePort = null;
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _disposeIsolate();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '300000');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate - Tarea Pesada')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Calcula la suma de 1..N en un Isolate para no bloquear la UI.',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'N'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _running
                      ? null
                      : () {
                          final n = int.tryParse(_controller.text) ?? 0;
                          _startCompute(n);
                        },
                  icon: const Icon(Icons.memory),
                  label: const Text('Calcular'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_running) ...[
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),
              const Center(child: Text('Procesando en isolate…')),
            ],
            if (_result != null) ...[
              const Text('Resultado:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_result!),
            ],
            if (_error != null) ...[
              Text('Error: $_error', style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
