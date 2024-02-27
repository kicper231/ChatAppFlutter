import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsersExceptCurrent(String currentUserId);
}

class FirebaseUserRepository implements UserRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<List<User>> getAllUsersExceptCurrent(String currentUserId) async {
    final querySnapshot = await _usersCollection.get();
    final users = querySnapshot.docs
        .map((doc) => User.fromSnapshot(doc))
        .where((user) => user.id != currentUserId)
        .toList();
    return users;
  }
}

class User {
  final String id;
  final String name;
  // Add more properties as needed

  User({required this.id, required this.name});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return User(
      id: snapshot.id,
      name: data['name'] ?? '',
      // Initialize other properties from the snapshot data
    );
  }
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {
  Stream<List<User>> getUsersExceptCurrent(String currentUserId);
}

class FirebaseChatRepository implements ChatRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Stream<List<User>> getUsersExceptCurrent(String currentUserId) {
    FirebaseFirestore.instance.collection("users").snapshots()
    return _usersCollection
        .where('userId', isNotEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList());
  }
}

class User {
  final String userId;
  final String name;

  User({required this.userId, required this.name});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return User(
      userId: snapshot.id,
      name: data['name'] ?? '',
    );
  }
}
