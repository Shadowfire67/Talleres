import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/universidad_list_page.dart';
import '../views/universidad_form_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      name: 'universidades',
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(
        child: UniversidadesListPage(),
      ),
    ),
    GoRoute(
      name: 'universidadNew',
      path: '/universidades/nueva',
      pageBuilder: (context, state) => const MaterialPage(
        child: UniversidadFormPage(),
      ),
    ),
  ],
);
