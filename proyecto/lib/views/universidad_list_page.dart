import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/universidad_service.dart';
import '../models/universidad.dart';

class UniversidadesListPage extends StatelessWidget {
  const UniversidadesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = UniversidadService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades (Firestore)'),
      ),
      body: StreamBuilder<List<Universidad>>(
        stream: service.streamUniversidades(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error al cargar: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final items = snapshot.data ?? const [];
          if (items.isEmpty) {
            return const Center(
              child: Text('No hay universidades. Crea la primera!'),
            );
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final u = items[i];
              return ListTile(
                title: Text(u.nombre),
                subtitle: Text('${u.nit} • ${u.paginaWeb}'),
                trailing: IconButton(
                  tooltip: 'Eliminar',
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Eliminar universidad'),
                        content: Text('¿Eliminar "${u.nombre}"?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancelar'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Eliminar'),
                          ),
                        ],
                      ),
                    );
                    if (ok == true) {
                      await service.deleteById(u.id);
                      // Firestore stream actualizará la UI solo.
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.goNamed('universidadNew'),
        icon: const Icon(Icons.add),
        label: const Text('Nueva'),
      ),
    );
  }
}
