import '../error_handler.dart';
import '../models/better_auth_exception.dart';

class GenericErrorHandler implements BaseErrorHandler {
  @override
  BetterAuthException handleError(error, [StackTrace? stackTrace]) {
    return BetterAuthException(
      message: 'An unexpected error occurred. Please try again.',
      code: BetterAuthExceptionCode.unknown,
    );
  }
}
