import 'package:better_auth_client/src/core/handlers/error-handler/models/better_auth_exception.dart';
import 'package:better_auth_client/src/models/response/user.dart';
import 'package:better_auth_client/src/sign-up/src/sign_up_client_impl.dart';

import '../core/types.dart';

abstract class SignupClient {
  static SignupClient get getDefaultInstance => SignUpClientImpl();

  Future<({BetterAuthException? error, User? user})> email({
    required String email,
    required String password,
    String? name,
    String? image,
    String? callbackUrl,
    Map<String, dynamic>? data,
    Success<User>? onSuccess,
    Error<BetterAuthException>? onError,
  });
}
