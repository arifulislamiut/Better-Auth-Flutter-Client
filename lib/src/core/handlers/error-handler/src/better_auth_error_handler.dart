import '../error_handler.dart';
import '../models/better_auth_exception.dart';

class BetterAuthErrorHandler implements BaseErrorHandler {
  @override
  BetterAuthException handleError(error, [StackTrace? stackTrace]) {
    return BetterAuthException(
      message: 'An error occurred',
      code: BetterAuthExceptionCode.serverError,
    );
  }
}
