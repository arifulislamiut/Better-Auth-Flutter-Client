class BetterAuthException implements Exception {
  final String? message;
  final BetterAuthExceptionCode? code;
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
  invalidEmailOrPassword,
  invalidRequest,
  unknown,
  unauthorized;

  static final Map<String, BetterAuthExceptionCode> _jsonToEnumMap = {
    'NETWORK_ISSUE': BetterAuthExceptionCode.networkIssue,
    'NO_USER_FOUND': BetterAuthExceptionCode.noUserFound,
    'SERVER_ERROR': BetterAuthExceptionCode.serverError,
    'INVALID_EMAIL_OR_PASSWORD': BetterAuthExceptionCode.invalidEmailOrPassword,
    'INVALID_REQUEST': BetterAuthExceptionCode.invalidRequest,
    'UNAUTHORIZED': BetterAuthExceptionCode.unauthorized,
  };

  static BetterAuthExceptionCode fromJson(String value) {
    return _jsonToEnumMap[value] ?? BetterAuthExceptionCode.unknown;
  }

  String toJson() {
    return _jsonToEnumMap.entries
        .firstWhere(
          (entry) => entry.value == this,
          orElse:
              () => const MapEntry('UNKNOWN', BetterAuthExceptionCode.unknown),
        )
        .key;
  }
}
