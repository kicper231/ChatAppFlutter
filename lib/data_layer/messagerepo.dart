import 'package:chatapp/data_layer/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        return snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList();
      });
    } catch (e) {
      return const Stream.empty();
    }
  }
}
