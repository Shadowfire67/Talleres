import 'package:flutter/material.dart';
import 'screens/async_demo_page.dart';
import 'screens/isolate_demo_page.dart';
import 'screens/timer_demo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
            ),
          ),
        ],
      ),
    );
  }
}
