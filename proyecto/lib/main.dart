import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _titulo = "Hola, Flutter";

  void _cambiarTitulo() {
    setState(() {
      _titulo = _titulo == "Hola, Flutter"
          ? "¡Título cambiado!"
          : "Hola, Flutter";
    });

    // Mostrar SnackBar
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Título actualizado")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titulo), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nombre centrado
            const Center(
              child: Text(
                "Juan Manuel Martinez Jojoa",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // Row con imágenes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Imagen de Internet
                Image.network(
                  "https://brandlogos.net/wp-content/uploads/2021/12/flutter-brandlogo.net_-512x512.png",
                  width: 100,
                ),
                // Imagen desde assets
                Image.asset(
                  "assets/flutter.png", // <-- coloca tu imagen en /assets
                  width: 100,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Botón que cambia el título
            ElevatedButton(
              onPressed: _cambiarTitulo,
              child: const Text("Cambiar título"),
            ),

            const SizedBox(height: 20),

            // Container con estilo
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade50,
              ),
              child: const Text("Este es un texto dentro de un Container"),
            ),

            const SizedBox(height: 20),

            // ListView dentro de un Expanded
            Expanded(
              child: ListView(
                children: const [
                  ListTile(leading: Icon(Icons.person), title: Text("Perfil")),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Configuración"),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Cerrar sesión"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Botón extra en la parte inferior
      floatingActionButton: OutlinedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Acción adicional ejecutada")),
          );
        },
        icon: const Icon(Icons.star),
        label: const Text("Extra"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
