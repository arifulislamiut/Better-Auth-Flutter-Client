class Session {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final DateTime expiresAt;
  final String token;
  final String? ipAddress;
  final String? userAgent;

  Session({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.expiresAt,
    required this.token,
    this.ipAddress,
    this.userAgent,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      userId: json['userId'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      token: json['token'] as String,
      ipAddress: json['ipAddress'] as String?,
      userAgent: json['userAgent'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
      'expiresAt': expiresAt.toIso8601String(),
      'token': token,
      'ipAddress': ipAddress,
      'userAgent': userAgent,
    };
  }
}
