class BetterAuthHttpResponse {
  final Map<String, dynamic> body;
  final int? statusCode;
  final Map<String, String>? headers;

  BetterAuthHttpResponse({
    this.body = const {},
    required this.statusCode,
    this.headers,
  });
}
