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
  Stream<List<Friend>> getFriends() async* {
    try {
      final friends = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .snapshots()
          .map((event) => event.data()!['friends']);

      final friendslist = friends.asyncMap((friendIds) async {
        final friendDocs = await _firestore
            .collection('users')
            .where('uid',
                whereIn: friendIds.map((friend) => friend['uid']).toList())
            .get();

        final friendsList = friendDocs.docs.map((doc) {
          final friendData = doc.data();
          friendData['lastMessage'] = friendIds
              .firstWhere((element) => element['uid'] == doc.id)['lastMessage'];
          friendData['timestamp'] = friendIds
              .firstWhere((element) => element['uid'] == doc.id)['timestamp'];
          // friendIds['lastMessage']; // Update lastMessage field
          // friendData['timestamp'] = friendIds['timestamp'];
          // Update timestamp field
          return Friend.fromMap(friendData);
        }).toList();

        // Rest of the code...

        return friendsList;
      });
      yield* friendslist;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addFriend(String userEmail) async {
    try {
      final userRef = await _firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userRef.docs.isEmpty) {
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
      // stworzenie dwóch
      Friend newFriend = Friend(email: userEmail, userId: userId);
      Friend newFriendtwo = Friend(
          email: _auth.currentUser!.email!, userId: _auth.currentUser!.uid);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'friends': FieldValue.arrayUnion([newFriend.toMap()]),
      });
      // await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      //   'friends': FieldValue.arrayUnion([newFriendtwo.toMap()]),
      // });
      // await _firestore.collection('users').doc(userId).update({
      //   'friends': FieldValue.arrayUnion([newFriend.toMap()]),
      // });
      await _firestore.collection('users').doc(userId).update({
        'friends': FieldValue.arrayUnion([newFriendtwo.toMap()]),
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
