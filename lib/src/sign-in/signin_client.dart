import 'package:better_auth_client/better_auth_client.dart';
import 'package:better_auth_client/src/core/handlers/error-handler/models/better_auth_exception.dart';

import '../core/types.dart';
import 'src/signin_client_impl.dart';

abstract class SigninClient {
  static SigninClient getInstance(String baseUrl) => SignInClientImpl();

  Future<({BetterAuthException? error, User? user})> email({
    required String email,
    required String password,
    Success<User>? onSuccess,
    Error<BetterAuthException>? onError,
  });

  Future<User> anonymous(Success? onSuccess, Error? onError);

  Future<void> social({
    required Providers provider,
    Map<String, dynamic>? idToken,
    Success<User>? onSuccess,
    Error<BetterAuthException>? onError,
  });
}
