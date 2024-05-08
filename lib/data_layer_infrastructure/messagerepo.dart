import 'package:chatapp/models_domain/model/friend.dart';
import 'package:chatapp/models_domain/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class MessageRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverId, String message) async {
    //current user info
    String senderId = _auth.currentUser!.uid;

    //make a new message
    Message newMessage = Message(
        senderId: senderId,
        senderEmail: _auth.currentUser!.email!,
        receiverId: receiverId,
        message: message,
        timestamp: Timestamp.now());

    // stworzenie chat roomu
    List<String> members = [senderId, receiverId];
    members.sort();
    String chatRoomId = members.join('_');

    await _firestore
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());

    // update friends and last message
    final listasender = await _firestore
        .collection('users')
        .doc(senderId)
        .get()
        .then((value) => (value.data()!['friends'] as List<dynamic>)
            .map((e) => Friend.fromMap(e))
            .toList());

    final listreceiver = await _firestore
        .collection('users')
        .doc(receiverId)
        .get()
        .then((value) => (value.data()!['friends'] as List<dynamic>)
            .map((e) => Friend.fromMap(e))
            .toList());

    Friend receiver =
        listasender.firstWhere((element) => element.userId == receiverId);
    Friend sender =
        listreceiver.firstWhere((element) => element.userId == senderId);

    sender.lastMessage = message;
    sender.timestamp = Timestamp.now().microsecondsSinceEpoch.toString();
    receiver.lastMessage = message;
    receiver.timestamp = Timestamp.now().microsecondsSinceEpoch.toString();

    // nie wiem co tu zaszlo tak podpowiedzial bóg google
    await _firestore
        .collection('users')
        .doc(senderId)
        .update({'friends': listasender.map((e) => e.toMap()).toList()});
    await _firestore
        .collection('users')
        .doc(receiverId)
        .update({'friends': listreceiver.map((e) => e.toMap()).toList()});
  }

  //get messages
  Stream<List<Message>> getMessages(String receiverId) {
    try {
      String senderId = _auth.currentUser!.uid;

      // stworzenie chat roomu
      List<String> members = [senderId, receiverId];
      members.sort();
      String chatRoomId = members.join('_');

      return _firestore
          .collection("chatrooms")
          .doc(chatRoomId)
          .collection("messages")
          .orderBy('timestamp', descending: false)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Message.fromMap(doc.data()))
            .toList()
            .reversed
            .toList();
      });
    } catch (e) {
      return const Stream.empty();
    }
  }
}
