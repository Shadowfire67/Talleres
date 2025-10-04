import 'dart:math';

class FakeService {
  /// Simula una consulta remota con una demora configurable.
  /// Retorna un mapa de datos o lanza una excepción simulada.
  static Future<Map<String, dynamic>> fetchData({
    Duration delay = const Duration(seconds: 2),
    bool shouldFail = false,
  }) async {
    print('[FakeService] antes de la petición');
    await Future.delayed(delay);
    print('[FakeService] durante la petición (después del delay)');

    if (shouldFail) {
      throw Exception('Error simulado al obtener datos');
    }

    final now = DateTime.now();
    final id = Random().nextInt(100000);
    final result = {
      'id': id,
      'timestamp': now.toIso8601String(),
      'message': 'Datos cargados correctamente',
    };
    print('[FakeService] después de la petición: $result');
    return result;
  }
}
