class Friend {
  final String userId;
  final String email;
  String? lastMessage;
  String? timestamp;
  Friend({
    required this.userId,
    required this.email,
    this.lastMessage,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': userId,
      'email': email,
      'lastMessage': lastMessage ?? '',
      'timestamp': timestamp ?? '',
    };
  }

  //from map
  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      userId: map['uid'],
      email: map['email'],
      lastMessage: map['lastMessage'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }
}
