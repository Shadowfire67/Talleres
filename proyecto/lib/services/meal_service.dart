import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/meal.dart';

class MealService {
  static const _baseUrl = 'www.themealdb.com';

  final http.Client _client;
  MealService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Meal>> searchMealsByName(String query) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/1/search.php', {'s': query});
    try {
      final res = await _client.get(uri);
      if (res.statusCode != 200) {
        throw HttpException('Error ${res.statusCode}: ${res.reasonPhrase}');
      }
      final data = json.decode(res.body) as Map<String, dynamic>;
      final meals = data['meals'] as List<dynamic>?;
      if (meals == null) return [];
      return meals.map((e) => Meal.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Meal?> getMealDetail(String id) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/1/lookup.php', {'i': id});
    try {
      final res = await _client.get(uri);
      if (res.statusCode != 200) {
        throw HttpException('Error ${res.statusCode}: ${res.reasonPhrase}');
      }
      final data = json.decode(res.body) as Map<String, dynamic>;
      final meals = data['meals'] as List<dynamic>?;
      if (meals == null || meals.isEmpty) return null;
      return Meal.fromJson(meals.first as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() => message;
}
