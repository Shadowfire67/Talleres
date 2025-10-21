import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto/main.dart';

void main() {
  testWidgets('Renderiza la pantalla de listado y muestra estado de carga', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Título del AppBar en la pantalla de listado
    expect(find.text('TheMealDB - Listado'), findsOneWidget);

    // Mientras carga debe mostrar un CircularProgressIndicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
