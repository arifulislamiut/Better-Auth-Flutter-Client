sealed class AppException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? data;

  AppException(this.message, [this.statusCode, this.data]);

  @override
  String toString() => "$runtimeType: $message";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppException) return false;
    return message == other.message &&
        statusCode == other.statusCode &&
        data == other.data;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode ^ data.hashCode;
}

class BadRequestException extends AppException {
  BadRequestException(super.message, [super.statusCode, super.data]);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message, [super.statusCode, super.data]);
}

class NotFoundException extends AppException {
  NotFoundException(super.message, [super.statusCode, super.data]);
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException(super.message, [super.statusCode, super.data]);
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class UnknownException extends AppException {
  UnknownException(super.message);
}

class GenericException extends AppException {
  GenericException(super.message);
}
