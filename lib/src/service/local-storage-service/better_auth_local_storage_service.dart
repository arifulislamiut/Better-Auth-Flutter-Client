import 'flutter_secure_impl.dart';

abstract class BetterAuthLocalStorage {
  String userKey = 'user';
  String tokenKey = 'token';
  static BetterAuthLocalStorage? _instance;

  static BetterAuthLocalStorage get getDefaultInstance =>
      _instance ?? FlutterSecureImpl();

  Future<void> create(String key, String value);
  Future<void> update(String key, String value);
  Future<void> delete(String key);
  Future<String> get(String key);
}
