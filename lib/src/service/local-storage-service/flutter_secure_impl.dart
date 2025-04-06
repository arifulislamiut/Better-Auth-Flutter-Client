import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'better_auth_local_storage_service.dart';

class FlutterSecureImpl extends BetterAuthLocalStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  @override
  Future<void> create(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> get(String key) async {
    try {
      return await _storage.read(key: key) ?? '';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }
}
