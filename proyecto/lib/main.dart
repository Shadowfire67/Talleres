import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

/// App principal con GoRouter
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/detail/:name',
          builder: (context, state) {
            final name = state.pathParameters['name'] ?? 'Sin nombre';
            return DetailPage(name: name);
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Taller Flutter',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Página principal con botones para go/push/replace
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Página Principal"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.grid_view), text: "GridView"),
              Tab(icon: Icon(Icons.info), text: "Navegación"),
            ],
          ),
        ),
        drawer: const Drawer(
          // <-- Tercer widget
          child: Center(child: Text("Menú lateral con Drawer")),
        ),
        body: TabBarView(
          children: [
            // ---- Tab 1: GridView ----
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Card(child: Center(child: Text("Item $index")));
              },
            ),
            // ---- Tab 2: Botones navegación ----
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.go('/detail/Go'),
                    child: const Text("Ir con go()"),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/detail/Push'),
                    child: const Text("Ir con push()"),
                  ),
                  ElevatedButton(
                    onPressed: () => context.replace('/detail/Replace'),
                    child: const Text("Ir con replace()"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pantalla secundaria que muestra el parámetro
class DetailPage extends StatefulWidget {
  final String name;
  const DetailPage({super.key, required this.name});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    print("initState() → Se ejecuta una sola vez al crear el widget");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(
      "didChangeDependencies() → Se ejecuta cuando cambian dependencias de InheritedWidgets",
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build() → Se ejecuta cada vez que se redibuja la pantalla");
    return Scaffold(
      appBar: AppBar(title: Text("Detalle: ${widget.name}")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Parámetro recibido: ${widget.name}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  print("setState() → Se ejecuta al cambiar el estado");
                });
              },
              child: const Text("Ejecutar setState()"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("dispose() → Se ejecuta al destruir el widget");
    super.dispose();
  }
}
