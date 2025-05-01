import 'dart:convert';
import 'package:better_auth_client/src/core/types.dart';
import 'package:http/http.dart' as http;

import '../../core/helpers/http_helper.dart';
import '../../models/response/better_auth_http_response.dart';

class HttpService with HttpHelper {
  // singleton
  static HttpService? _instance;
  static HttpService get instance => _instance ??= HttpService();
  late String baseUrl;
  void init(String baseUrl) {
    this.baseUrl = baseUrl;
  }

  Future<BetterAuthHttpResponse> getRequest(String path) =>
      handleRequest(() => http.get(getFullUrl(baseUrl, path)));

  Future<BetterAuthHttpResponse> deleteRequest(
    String path, {
    Map<String, String>? headers,
  }) => handleRequest(
    () => http.delete(getFullUrl(baseUrl, path), headers: headers),
  );

  Future<BetterAuthHttpResponse> patchRequest(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) => handleRequest(
    () => http.patch(getFullUrl(baseUrl, path), headers: headers, body: body),
  );

  Future<BetterAuthHttpResponse> postRequest(
    String path, {
    Map<String, String>? headers = appHeader,
    Map<String, dynamic>? body,
  }) => handleRequest(
    () => http.post(
      getFullUrl(baseUrl, path),
      headers: headers,
      body: jsonEncode(body),
    ),
  );

  Future<BetterAuthHttpResponse> putRequest(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) => handleRequest(
    () => http.put(getFullUrl(baseUrl, path), headers: headers, body: body),
  );
}
