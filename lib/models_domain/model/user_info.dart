class UserData {
  final String userId;
  final String email;
  final String? name;
  String? image;

  UserData({
    required this.userId,
    required this.email,
    this.name,
    this.image,
  });

  static UserData fromMap(Map<String, dynamic> map) {
    return UserData(
      userId: map['uid'],
      email: map['email'],
      name: map['name'],
      image: map['Image'],
    );
  }

  static Map<String, dynamic> toMap(UserData UserData) {
    return {
      'uid': UserData.userId,
      'email': UserData.email,
      'name': UserData.name,
      'Image': UserData.image,
    };
  }
}
