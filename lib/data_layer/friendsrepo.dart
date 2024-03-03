import 'package:chatapp/data_layer/model/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FriendsInterface {
  Stream<List<Friend>> getFriends();
  // Future<void> addFriend(User friend);
  // Future<void> removeFriend(User friend);
  void addFriend(String userId);
}

class FriendsRepository implements FriendsInterface {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FriendsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Friend>> getFriends() {
    try {
      return _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .snapshots()
          .map((snapshot) {
        final friends = snapshot['friends'];
        if (friends == null) {
          return [];
        }
        return (friends as List<dynamic>)
            .map((doc) =>
                Friend(email: doc['email'] ?? '', userId: doc['userId'] ?? ''))
            .toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addFriend(String userEmail) async {
    try {
      final UserRef = await _firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (UserRef.docs.isEmpty) {
        throw Exception('User not found');
      }

      //wyciagniecie id usera
      String userId = await _firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get()
          .then((value) => value.docs[0].id);
      if (userId == '') {
        throw Exception('User not found');
      }
      // sprawdzenie czy juz go nie ma w liscie znajomych
      Friend newFriend = Friend(email: userEmail, userId: userId);
      //dodanie
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'friends': FieldValue.arrayUnion([newFriend.toMap()]),
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
