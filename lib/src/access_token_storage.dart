import 'package:iv_project_core/iv_project_core.dart';

class AccessTokenStorage {
  const AccessTokenStorage._();

  static const String _key = 'access_token_key';

  static Future<void> saveToken(String token) async => await StorageService.setString(_key, token);

  static String? getToken() => StorageService.getString(_key);

  static Future<void> clearToken() async => await StorageService.remove(_key);
}
