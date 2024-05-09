class Friend {
  final String userId;
  final String email;
  String? lastMessage;
  String? timestamp;
  String? image;
  String name;

  Friend({
    required this.userId,
    required this.email,
    this.lastMessage,
    this.timestamp,
    this.image,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': userId,
      'email': email,
      'lastMessage': lastMessage ?? '',
      'timestamp': timestamp ?? '',
      'Image': image ?? '',
    };
  }

  //from map
  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      userId: map['uid'],
      email: map['email'],
      name: map['name'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      timestamp: map['timestamp'] ?? '',
      image: map['Image'] ?? '',
    );
  }
}
