import 'package:better_auth_client/src/core/exceptions/app_exceptions.dart';
import 'package:better_auth_client/src/models/response/better_auth_error_response.dart';

import '../error_handler.dart';
import '../models/better_auth_exception.dart';

class BetterAuthErrorHandler implements BaseErrorHandler {
  @override
  BetterAuthException handleError(error, [StackTrace? stackTrace]) {
    // lets check if the error has a response body
    if (error.data == null) {
      return BetterAuthException(
        message: 'An error occurred',
        code: BetterAuthExceptionCode.unknown,
      );
    }
    final betterAuthException = BetterAuthErrorResponse.fromJson(error.data!);
    return BetterAuthException(
      message: betterAuthException.message,
      code: betterAuthException.code,
    );
  }
}
