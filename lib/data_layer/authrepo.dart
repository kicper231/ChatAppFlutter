import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  //instance of auth
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({FirebaseAuth? auth, FirebaseFirestore? firebase})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firebase ?? FirebaseFirestore.instance;

  //sing in
  Future<void> singIn(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _firestore.collection('users').doc(user.user!.uid).set({
        'email': email,
        'uid': user.user!.uid,
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception(e);
    }
  }
  // sing up

  Future<void> signup(String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _firestore.collection('users').doc(user.user!.uid).set({
        'email': email,
        'uid': user.user!.uid,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  //sing out

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
