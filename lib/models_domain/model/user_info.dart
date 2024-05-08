class UserInfo {
  final String userId;
  final String email;
  final String? name;
  String? image;

  UserInfo({
    required this.userId,
    required this.email,
    this.name,
    this.image,
  });

  static UserInfo fromMap(Map<String, dynamic> map) {
    return UserInfo(
      userId: map['uid'],
      email: map['email'],
      name: map['name'],
      image: map['Image'],
    );
  }

  static Map<String, dynamic> toMap(UserInfo userInfo) {
    return {
      'uid': userInfo.userId,
      'email': userInfo.email,
      'name': userInfo.name,
      'Image': userInfo.image,
    };
  }
}
