import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageKeys {
  // SharedPrefs
  static const name = 'name';
  static const email = 'email';
  static const theme = 'theme';
  static const locale = 'locale';

  // Secure
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
}

class LocalStorage {
  static const _secure = FlutterSecureStorage();

  // Shared Preferences
  static Future<void> saveUser({String? name, String? email}) async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null) await prefs.setString(StorageKeys.name, name);
    if (email != null) await prefs.setString(StorageKeys.email, email);
  }

  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(StorageKeys.name),
      'email': prefs.getString(StorageKeys.email),
    };
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StorageKeys.name);
    await prefs.remove(StorageKeys.email);
  }

  // Secure Storage
  static Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _secure.write(key: StorageKeys.accessToken, value: accessToken);
    if (refreshToken != null) {
      await _secure.write(key: StorageKeys.refreshToken, value: refreshToken);
    }
  }

  static Future<String?> getAccessToken() =>
      _secure.read(key: StorageKeys.accessToken);
  static Future<String?> getRefreshToken() =>
      _secure.read(key: StorageKeys.refreshToken);

  static Future<void> clearTokens() async {
    await _secure.delete(key: StorageKeys.accessToken);
    await _secure.delete(key: StorageKeys.refreshToken);
  }

  static Future<void> logout() async {
    await clearUser();
    await clearTokens();
  }
}
