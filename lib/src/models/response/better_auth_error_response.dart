import 'package:better_auth_client/src/core/handlers/error-handler/models/better_auth_exception.dart';

class BetterAuthErrorResponse extends BetterAuthException {
  BetterAuthErrorResponse({required super.message, required super.code});
  BetterAuthErrorResponse.fromJson(Map<String, dynamic> json)
    : super(
        message: json['message'] ?? 'An error occurred',
        code: BetterAuthExceptionCode.fromJson(json['code'] ?? 'unknown'),
      );
}
