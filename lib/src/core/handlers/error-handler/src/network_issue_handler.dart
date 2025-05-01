import 'dart:async';
import 'dart:io';

import 'package:better_auth_client/src/core/exceptions/app_exceptions.dart';

import '../error_handler.dart';
import '../models/better_auth_exception.dart';

class NetworkIssueHandler extends BaseErrorHandler {
  @override
  BetterAuthException handleError(error, [StackTrace? stackTrace]) {
    if (error is SocketException) {
      return BetterAuthException(
        message: 'No internet connection',
        code: BetterAuthExceptionCode.networkIssue,
      );
    } else if (error is TimeoutException) {
      return BetterAuthException(
        message: 'Request timed out',
        code: BetterAuthExceptionCode.networkIssue,
      );
    } else if (error is NetworkException) {
      return BetterAuthException(
        message: error.message,
        code: BetterAuthExceptionCode.networkIssue,
      );
    } else {
      return BetterAuthException(
        message: 'An error occurred',
        code: BetterAuthExceptionCode.networkIssue,
      );
    }
  }
}
