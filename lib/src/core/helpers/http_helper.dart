import 'dart:convert';
import 'dart:developer';


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
      } else {
        throw Exception('HTTP Error: ${res.statusCode} - ${res.body}');
      }
    } catch (e) {
      log('Request failed: $e', error: e);
      rethrow;
    }
  }

  Uri getFullUrl(String baseUrl, String path) {
    return Uri.parse('$baseUrl$path');
  }
}
