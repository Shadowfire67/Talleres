import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/meal.dart';
import '../services/meal_service.dart';

class MealListPage extends StatefulWidget {
  const MealListPage({super.key});

  @override
  State<MealListPage> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  final _service = MealService();
  late Future<List<Meal>> _future;
  final _controller = TextEditingController(text: 'chicken');

  @override
  void initState() {
    super.initState();
    _future = _service.searchMealsByName(_controller.text);
  }

  void _search() {
    setState(() {
      _future = _service.searchMealsByName(_controller.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TheMealDB - Listado')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Buscar por nombre',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _search,
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Meal>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return _ErrorView(
                    message: 'Ocurrió un error al cargar: ${snapshot.error}',
                    onRetry: _search,
                  );
                }
                final meals = snapshot.data ?? [];
                if (meals.isEmpty) {
                  return const Center(child: Text('Sin resultados'));
                }
                return ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return ListTile(
                      leading: meal.thumbnail != null
                          ? Image.network(
                              meal.thumbnail!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.fastfood),
                      title: Text(meal.name),
                      subtitle: Text(
                        [
                          if ((meal.category ?? '').isNotEmpty) meal.category!,
                          if ((meal.area ?? '').isNotEmpty) meal.area!,
                        ].join(' · '),
                      ),
                      onTap: () => context.goNamed(
                        'mealDetail',
                        pathParameters: {'id': meal.id},
                        extra: meal,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
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
            ),
          ],
        ),
      ),
    );
  }
}
