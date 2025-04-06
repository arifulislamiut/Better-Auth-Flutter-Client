class BetterAuthException implements Exception {
  final String message;
  final BetterAuthExceptionCode code;
  final String? stackTrace;

  BetterAuthException({
    required this.message,
    required this.code,
    this.stackTrace,
  });
}

enum BetterAuthExceptionCode {
  networkIssue,
  noUserFound,
  serverError,
  invalidCredentials,
  invalidRequest,
  unknown,
  unauthorized,
}
