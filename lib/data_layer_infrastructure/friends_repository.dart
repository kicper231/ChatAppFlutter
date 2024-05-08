import 'package:chatapp/models_domain/model/friend.dart';
import 'package:chatapp/models_domain/model/user_info.dart' as Info;
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
      // pobranie znajomych
      final friendsStream = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .snapshots()
          .map((event) => event.data()!['friends'] as List<dynamic>?);

      // obsluga znajomych
      final friendsListStream = friendsStream.asyncMap((friendIds) async {
        if (friendIds == null || friendIds.isEmpty) {
          return List<Friend>.empty();
        }

        // zapytanie do
        final friendDocs = await _firestore
            .collection('users')
            .where('uid',
                whereIn: friendIds.map((friend) => friend['uid']).toList())
            .get();

        // przypisanie ostatnich znajomosci
        final friendsList = friendDocs.docs.map((doc) {
          final friendData = doc.data();
          friendData['lastMessage'] = friendIds
              .firstWhere((element) => element['uid'] == doc.id)['lastMessage'];
          friendData['timestamp'] = friendIds
              .firstWhere((element) => element['uid'] == doc.id)['timestamp'];

          return Friend.fromMap(friendData);
        }).toList();

        return friendsList;
      });

      yield* friendsListStream;
    } catch (e) {
      throw Exception('Failed to fetch friends: ${e.toString()}');
    }
  }

  Future<Info.UserInfo> getUserInfo() async {
    try {
      final userDoc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      final userData = userDoc.data();
      if (userData == null) {
        throw Exception('User not found');
      }
      return Info.UserInfo.fromMap(userData);
    } catch (e) {
      throw Exception('Failed to fetch user info: ${e.toString()}');
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
