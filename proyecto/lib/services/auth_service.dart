import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_models.dart';

class AuthService {
  static const _base = 'parking.visiontic.com.co';

  final http.Client _client;
  AuthService({http.Client? client}) : _client = client ?? http.Client();

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.https(_base, '/api/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});
    try {
      final res = await _client.post(uri, headers: headers, body: body);
      if (res.statusCode != 200) {
        // Intentar extraer mensaje del backend si viene
        String message = 'Error ${res.statusCode}';
        try {
          final data = json.decode(res.body) as Map<String, dynamic>;
          message = data['message']?.toString() ?? message;
        } catch (_) {}
        throw AuthException(message);
      }
      final data = json.decode(res.body) as Map<String, dynamic>;

      // Token puede venir como 'access_token', 'token', o dentro de 'data'
      String? accessToken =
          data['access_token']?.toString() ?? data['token']?.toString();
      accessToken ??= (data['data'] is Map
          ? (data['data']['access_token']?.toString())
          : null);
      final refreshToken = data['refresh_token']?.toString();

      if (accessToken == null || accessToken.isEmpty) {
        throw AuthException('No se recibió access_token en la respuesta');
      }

      // Usuario puede venir en 'user' o 'data.user'
      Map<String, dynamic>? userJson;
      if (data['user'] is Map) userJson = data['user'] as Map<String, dynamic>;
      if (data['data'] is Map && (data['data']['user'] is Map)) {
        userJson = data['data']['user'] as Map<String, dynamic>;
      }

      final user = AuthUser(
        name: userJson?['name']?.toString(),
        email: userJson?['email']?.toString() ?? email,
      );

      return AuthResult(
        tokens: AuthTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
        user: user,
      );
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Error de red o de parseo: $e');
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}
