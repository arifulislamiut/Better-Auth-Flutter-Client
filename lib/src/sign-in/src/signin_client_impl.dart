
import 'package:better_auth_client/src/core/configs/api_endpoints.dart';
import 'package:better_auth_client/src/core/configs/enums/providers.dart';
import 'package:better_auth_client/src/core/handlers/error-handler/models/better_auth_exception.dart';
import 'package:better_auth_client/src/core/types.dart';
import 'package:better_auth_client/src/models/response/user.dart';
import 'package:better_auth_client/src/service/http-service/http_service.dart';
import 'package:better_auth_client/src/service/user-local-service/user_local_service.dart';
import 'package:better_auth_client/src/sign-in/signin_client.dart';

import '../../core/handlers/error-handler/error_handler.dart';
import '../../service/local-storage-service/better_auth_local_storage_service.dart';

class SignInClientImpl with ErrorHandler implements SigninClient {
  SignInClientImpl({
    HttpService? httpService,
    BetterAuthLocalStorage? localStorage,
    UserLocalService? userLocalService,
  }) : _httpService = httpService ?? HttpService.instance,
       _userLocalService =
           userLocalService ??
           UserLocalServiceImpl(localStorageService: localStorage!);
  final HttpService _httpService;
  final UserLocalService _userLocalService;
  @override
  Future<User> anonymous(Success? onSuccess, Error? onError) {
    // TODO: implement anonymous
    throw UnimplementedError();
  }

  @override
  Future<({BetterAuthException? error, User? user})> email({
    required String email,
    required String password,
    Success<User>? onSuccess,
    Error<BetterAuthException>? onError,
  }) async {
    try {
      final url = ApiEndpoints.signIn;
      final response = await _httpService.postRequest(
        url,
        body: {'email': email, 'password': password},
      );
      final user = User.fromJson(response.body);
      await _userLocalService.setUser(user);
      onSuccess?.call(user);
      return (error: null, user: user);
    } catch (e) {
      final error = handleException(e);
      onError?.call(error);
      return (error: error, user: null);
    }
  }

  @override
  Future<({BetterAuthException? error, String? loginUrl})> social({
    required Providers provider,
    Map<String, dynamic>? idToken,
    Success<User>? onSuccess,
    Error<BetterAuthException>? onError,
  }) async {
    try {
      final res = await _httpService.postRequest(
        ApiEndpoints.signInSocial,
        body: {"provider": provider.name},
      );

      final {"url": String loginUrl, "redirect": redirect} = res.body;
      return (error: null, loginUrl: loginUrl);
    } catch (e) {
      final error = handleException(e);
      onError?.call(error);
      return (error: error, loginUrl: null);
    }
  }
}
