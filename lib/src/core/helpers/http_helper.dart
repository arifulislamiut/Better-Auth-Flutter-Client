import 'dart:convert';

import 'package:better_auth_client/src/core/exceptions/app_exceptions.dart';
import 'package:http/http.dart';

import '../../models/response/better_auth_http_response.dart';

mixin HttpHelper {
  Future<BetterAuthHttpResponse> handleRequest(
    Future<dynamic> Function() request,
  ) async {
    try {
      final res = await request();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final body = jsonDecode(res.body);
        return BetterAuthHttpResponse(body: body, statusCode: res.statusCode);
      }

      throw _parseResponseException(res);
    } catch (e) {
      if (e is ClientException) {
        throw NetworkException(e.message);
      } else if (e is AppException) {
        rethrow;
      } else {
        throw UnknownException('-');
      }
    }
  }

  _parseResponseException(res) {
    final statusCode = res.statusCode;

    if (statusCode == null) {
      return UnknownException('-');
    }
    final data = jsonDecode(res.body);
    final message = data['message'] as String? ?? 'An error occurred';
    switch (statusCode) {
      case 400:
        return BadRequestException(message, statusCode, data);
      case 401:
        return UnauthorizedException(message, statusCode, data);
      case 404:
        return NotFoundException(message, statusCode, data);
      case 422:
        return UnauthorizedException(message, statusCode, data);
      case 500:
        return InternalServerErrorException(message, statusCode, data);

      default:
        return UnknownException(message);
    }
  }

  Uri getFullUrl(String baseUrl, String path) {
    return Uri.parse('$baseUrl$path');
  }
}
