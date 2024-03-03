class Friend {
  final String userId;
  final String email;
  Friend({required this.userId, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
    };
  }
}
