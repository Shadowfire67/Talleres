import 'package:flutter/material.dart';

import '../storage/local_storage.dart';

class EvidencePage extends StatefulWidget {
  const EvidencePage({super.key});

  @override
  State<EvidencePage> createState() => _EvidencePageState();
}

class _EvidencePageState extends State<EvidencePage> {
  bool _loading = true;
  String? _name;
  String? _email;
  bool _hasToken = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final user = await LocalStorage.getUser();
    final token = await LocalStorage.getAccessToken();
    setState(() {
      _name = user['name'];
      _email = user['email'];
      _hasToken = token != null && token.isNotEmpty;
      _loading = false;
    });
  }

  Future<void> _logout() async {
    await LocalStorage.logout();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Sesión cerrada')));
      await _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Evidencia de almacenamiento')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: ${_name ?? '-'}'),
                  Text('Email: ${_email ?? '-'}'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Token: '),
                      Chip(
                        label: Text(_hasToken ? 'Presente' : 'Sin token'),
                        backgroundColor: _hasToken
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _load,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refrescar'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _logout,
                        icon: const Icon(Icons.logout),
                        label: const Text('Cerrar sesión'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
