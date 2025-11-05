import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/universidad.dart';

class UniversidadService {
  static const String collectionName = 'universidades';
  final _col = FirebaseFirestore.instance.collection(collectionName);

  Stream<List<Universidad>> streamUniversidades() {
    return _col.orderBy('nombre').snapshots().map(
          (s) => s.docs
              .map((d) => Universidad.fromDoc(d.id, d.data()))
              .toList(),
        );
  }

  Future<void> addUniversidad(Universidad u) async {
    await _col.add(u.toMap());
  }

  Future<void> deleteById(String id) async {
    await _col.doc(id).delete();
  }

  Future<void> updateById(String id, Map<String, dynamic> data) async {
    await _col.doc(id).update(data);
  }
}
