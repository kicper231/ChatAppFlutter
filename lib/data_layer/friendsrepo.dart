import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FriendsInterface {
  Stream<List<String>> getFriends();
  // Future<void> addFriend(User friend);
  // Future<void> removeFriend(User friend);
}

class FriendsRepository implements FriendsInterface {
  final FirebaseFirestore _firestore;

  FriendsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<String>> getFriends() {
    try {
      return _firestore.collection('users').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => doc['email'].toString()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
