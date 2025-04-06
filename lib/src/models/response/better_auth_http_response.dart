class BetterAuthHttpResponse {
  final Map<String, dynamic> body;
  final int? statusCode;

  BetterAuthHttpResponse({this.body = const {}, required this.statusCode});
}
