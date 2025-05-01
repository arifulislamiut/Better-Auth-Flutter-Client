import 'dart:async';
import 'dart:developer';
import 'package:better_auth_client/src/core/handlers/error-handler/models/better_auth_exception.dart';
import 'package:better_auth_client/src/models/response/better_auth_http_response.dart';
import 'package:better_auth_client/src/service/local-storage-service/better_auth_local_storage_service.dart';
import 'package:better_auth_client/src/service/user-local-service/user_local_service.dart';
import 'package:better_auth_client/src/sign-in/src/signin_client_impl.dart';
import 'package:better_auth_client/src/sign-up/src/sign_up_client_impl.dart';
import 'core/types.dart';
import 'models/response/user.dart';
import 'plugins/phone-auth/phone_auth_plugin.dart';
import 'service/http-service/http_service.dart';
import 'sign-in/signin_client.dart';
import 'sign-up/signup_client.dart';

class BetterAuthClient {
  static BetterAuthClient get instance => BetterAuthClient._internal();
  static BetterAuthLocalStorage? _localStorage;
  static HttpService? _httpService;
  static SigninClient? _signinClient;
  static SignupClient? _signupClient;
  static UserLocalService? _userLocalService;
  BetterAuthClient._internal();

  static String? _baseUrl;
  static Future<BetterAuthClient> create({
    required String baseUrl,
    BetterAuthLocalStorage? localStorage,
  }) async {
    _baseUrl = baseUrl;
    log('--------------------------------');
    log('Initializing better auth with base URL: $baseUrl');
    log('--------------------------------');

    _userLocalService = UserLocalServiceImpl(
      localStorageService:
          localStorage ?? BetterAuthLocalStorage.getDefaultInstance,
    );
    _signinClient = SignInClientImpl(
      httpService: _httpService ?? HttpService.instance,
      localStorage: localStorage,
      userLocalService: _userLocalService,
    );
    _signupClient = SignUpClientImpl(
      httpService: _httpService ?? HttpService.instance,
      localStorage: localStorage,
      userLocalService: _userLocalService,
    );
    BetterAuthLocalStorage.setInstance(localStorage);
    HttpService.instance.init(baseUrl);

    _userLocalService = UserLocalServiceImpl(
      localStorageService:
          _localStorage ?? BetterAuthLocalStorage.getDefaultInstance,
    );
    log('BetterAuth initialized successfully!');
    log('-------------Getting Current User-------------------');
    final user = await BetterAuthClient._internal().getCurrentUser();
    log(user?.toString() ?? 'No user found');
    log('----------------------------------------------------');

    return instance;
  }

  bool _isInitialized() {
    final isInitialized = _baseUrl != null;

    return isInitialized;
  }

  void _throwUninitialized() {
    throw Exception('BetterAuthClient has not been created');
  }

  SigninClient get signIn {
    return _signinClient!;
  }

  SignupClient get signUp {
    if (!_isInitialized()) {
      _throwUninitialized();
    }
    return _signupClient!;
  }

  Stream<User?> get userChanges =>
      _userLocalService?.userChanges ?? Stream.empty();

  /// signout
  Future<void> signOut({Success? onSuccess, Error? onError}) async {
    final currentUser = await getCurrentUser();
    if (currentUser != null) {
      await _userLocalService?.deleteUser();
      log('Signed out');
      onSuccess?.call(null);
    } else {
      final error = BetterAuthException(
        message: 'No user found',
        code: BetterAuthExceptionCode.noUserFound,
      );
      log(error.message.toString());
      onError?.call(error);
    }
  }

  Future<void> forgetPassword({
    required String email,
    Success<BetterAuthHttpResponse>? onSuccess,
    Error? onError,
  }) async {
    try {
      final response = await _httpService?.postRequest(
        ApiEndpoints.forgetPassword,
        body: {'email': email},
      );

      log('Password reset email sent');
      onSuccess?.call(response!);
      return;
    } catch (e) {
      // final error = BetterAuthException(
      //   message: e.toString(),
      //   code: BetterAuthExceptionCode,
      // );
      // log(error.message);
      // onError?.call(error);
      return;
    }
  }

  Future<({dynamic data, dynamic error})> resetPassword({
    required String newPassword,
    required String token,
    Success<BetterAuthHttpResponse>? onSuccess,
    Error? onError,
  }) async {
    try {
      final response = await _httpService?.postRequest(
        ApiEndpoints.resetPassword,
        body: {'newPassword': newPassword, 'token': token},
      );

      log('Password reset successful');
      onSuccess?.call(response!);
      return (data: response, error: null);
    } catch (e) {
      return (data: null, error: null);
    }
  }

  Future<void> sendVerificationEmail({
    required String email,
    required String callbackURL,
  }) {
    throw UnimplementedError();
  }

  //////// Plugins ////////

  PhoneAuthPlugin get phoneNumber {
    if (!_isInitialized()) {
      _throwUninitialized();
    }
    return PhoneAuthPlugin.instance;
  }

  /// get session
  Future<User?> getCurrentUser() async {
    return await _userLocalService?.getUser();
  }
}
