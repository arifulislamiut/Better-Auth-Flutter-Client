import 'dart:async';
import 'dart:io';

import 'package:better_auth_client/src/core/handlers/error-handler/models/better_auth_exception.dart';

import 'src/index.dart';

abstract class BaseErrorHandler {
  BetterAuthException handleError(dynamic error, [StackTrace? stackTrace]);
}

class _ErrorFactory {
  static BaseErrorHandler getErrorHandler(dynamic error) {
    return switch (error.runtimeType) {
      SocketException _ || TimeoutException _ => NetworkIssueHandler(),
      _ => GenericErrorHandler(),
    };
  }
}

mixin ErrorHandler {
  BetterAuthException handleException(dynamic error, [StackTrace? stackTrace]) {
    final errorHandler = _ErrorFactory.getErrorHandler(error);
    return errorHandler.handleError(error, stackTrace);
  }
}
