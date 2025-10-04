import 'package:flutter/material.dart';
import 'screens/async_demo_page.dart';
import 'screens/isolate_demo_page.dart';
import 'screens/timer_demo_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

/// App principal con GoRouter
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto Taller - Segundo Plano',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeMenuPage(),
    );
  }
}

class HomeMenuPage extends StatelessWidget {
  const HomeMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taller - Segundo Plano')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Selecciona un demo:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.downloading),
              title: const Text('1) Future + async/await'),
              subtitle: const Text('Carga simulada con estados: Cargando/Éxito/Error'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AsyncDemoPage()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('2) Timer (Cronómetro)'),
              subtitle: const Text('Iniciar / Pausar / Reanudar / Reiniciar'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TimerDemoPage()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.memory),
              title: const Text('3) Isolate (Tarea pesada)'),
              subtitle: const Text('Cálculo CPU-bound sin bloquear la UI'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IsolateDemoPage()),
              ),
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print("dispose() → Se ejecuta al destruir el widget");
    super.dispose();
  }
}
