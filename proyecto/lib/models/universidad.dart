class Universidad {
  final String id; // Firestore doc id
  final String nit;
  final String nombre;
  final String direccion;
  final String telefono;
  final String paginaWeb;

  Universidad({
    required this.id,
    required this.nit,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.paginaWeb,
  });

  factory Universidad.fromDoc(String id, Map<String, dynamic> json) {
    return Universidad(
      id: id,
      nit: (json['nit'] ?? '').toString(),
      nombre: (json['nombre'] ?? '').toString(),
      direccion: (json['direccion'] ?? '').toString(),
      telefono: (json['telefono'] ?? '').toString(),
      paginaWeb: (json['pagina_web'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() => {
        'nit': nit,
        'nombre': nombre,
        'direccion': direccion,
        'telefono': telefono,
        'pagina_web': paginaWeb,
      };
}
