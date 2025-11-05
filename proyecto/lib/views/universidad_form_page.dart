import 'package:flutter/material.dart';

import '../models/universidad.dart';
import '../services/universidad_service.dart';

class UniversidadFormPage extends StatefulWidget {
  const UniversidadFormPage({super.key});

  @override
  State<UniversidadFormPage> createState() => _UniversidadFormPageState();
}

class _UniversidadFormPageState extends State<UniversidadFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nit = TextEditingController();
  final _nombre = TextEditingController();
  final _direccion = TextEditingController();
  final _telefono = TextEditingController();
  final _pagina = TextEditingController();
  bool _loading = false;
  String? _error;

  final _service = UniversidadService();

  String? _notEmpty(String? v, String label) {
    if (v == null || v.trim().isEmpty) return 'Ingresa $label';
    return null;
  }

  String? _validUrl(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Ingresa URL';
    final ok = Uri.tryParse(value)?.hasAbsolutePath == true &&
        (value.startsWith('http://') || value.startsWith('https://'));
    return ok ? null : 'URL inválida (usa http/https)';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    setState(() => _error = null);
    try {
      final u = Universidad(
        id: '',
        nit: _nit.text.trim(),
        nombre: _nombre.text.trim(),
        direccion: _direccion.text.trim(),
        telefono: _telefono.text.trim(),
        paginaWeb: _pagina.text.trim(),
      );
      await _service.addUniversidad(u);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Universidad creada')),
      );
      Navigator.of(context).maybePop();
    } catch (e) {
      setState(() => _error = 'Error: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Universidad')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nit,
                decoration: const InputDecoration(
                  labelText: 'NIT',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _notEmpty(v, 'el NIT'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nombre,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _notEmpty(v, 'el nombre'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _direccion,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _notEmpty(v, 'la dirección'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _telefono,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _notEmpty(v, 'el teléfono'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pagina,
                decoration: const InputDecoration(
                  labelText: 'Página web',
                  hintText: 'https://example.com',
                  border: OutlineInputBorder(),
                ),
                validator: _validUrl,
              ),
              const SizedBox(height: 16),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child:
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
