import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/meal.dart';
import '../views/meal_detail_page.dart';
import '../views/meal_list_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      name: 'mealList',
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(
        child: MealListPage(),
      ),
    ),
    GoRoute(
      name: 'mealDetail',
      path: '/meal/:id',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        final extra = state.extra;
        return MaterialPage(
          child: MealDetailPage(
            id: id,
            initialMeal: extra is Meal ? extra : null,
          ),
        );
      },
    ),
  ],
);
