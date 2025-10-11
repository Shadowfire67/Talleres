import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../services/meal_service.dart';

class MealDetailPage extends StatefulWidget {
  final String id;
  final Meal? initialMeal; // opcional, recibido vía extra
  const MealDetailPage({super.key, required this.id, this.initialMeal});

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  final _service = MealService();
  Meal? _meal;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _meal = widget.initialMeal;
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final m = await _service.getMealDetail(widget.id);
      if (m == null) {
        setState(() {
          _error = 'No se encontró el detalle de la receta';
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se encontró el detalle de la receta')),
          );
        }
      } else {
        setState(() {
          _meal = m;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error al cargar: $e';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de red: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_meal?.name ?? 'Detalle'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorView(message: _error!, onRetry: _fetch)
              : _meal == null
                  ? const Center(child: Text('Sin datos'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_meal!.thumbnail != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(_meal!.thumbnail!),
                            ),
                          const SizedBox(height: 12),
                          Text(
                            _meal!.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              if ((_meal!.category ?? '').isNotEmpty)
                                Chip(label: Text('Categoría: ${_meal!.category}')),
                              if ((_meal!.area ?? '').isNotEmpty)
                                Chip(label: Text('Área: ${_meal!.area}')),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Instrucciones',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(_meal!.instructions ?? 'Sin instrucciones'),
                        ],
                      ),
                    ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            )
          ],
        ),
      ),
    );
  }
}
