class User {
  final String? id;
  final String? name;
  final String? email;
  final bool? emailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;
  final String? token;
  final String? cookie; // Session cookie from Set-Cookie header
  final Map<String, dynamic>? data;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerified,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.token,
    this.cookie,
    this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final userMap = json['user'];
    final token = json['token'];
    final cookie = json['cookie']; // Extract cookie if provided

    // extract known fields
    final knownFields = [
      'id',
      'name',
      'email',
      'emailVerified',
      'createdAt',
      'updatedAt',
      'image',
    ];

    // additional data provided by the user
    final Map<String, dynamic> additionalData = {};
    if (userMap != null) {
      for (final key in userMap.keys) {
        if (!knownFields.contains(key)) {
          additionalData[key] = userMap[key];
        }
      }
    }

    return User(
      id: userMap['id'] as String,
      name: userMap['name'] as String,
      email: userMap['email'] as String,
      emailVerified: userMap['emailVerified'] as bool,
      createdAt: DateTime.parse(userMap['createdAt'] as String),
      updatedAt: DateTime.parse(userMap['updatedAt'] as String),
      image: userMap['image'] as String?,
      token: token as String?,
      cookie: cookie as String?,
      data: additionalData.isNotEmpty ? additionalData : null,
    );
  }

  static User empty() {
    return User();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userMap = {
      'id': id,
      'name': name,
      'email': email,
      'emailVerified': emailVerified,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'image': image,
    };

    if (data != null) {
      userMap.addAll(data!);
    }

    return {
      'redirect': false,
      'token': token,
      'cookie': cookie,
      'user': userMap,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, emailVerified: $emailVerified, createdAt: $createdAt, updatedAt: $updatedAt, image: $image)';
  }
}
