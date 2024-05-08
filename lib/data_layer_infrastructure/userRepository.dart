import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserRepository {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sing in
  Future<void> singIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // _firestore.collection('users').doc(user.user!.uid).set({
      //   'email': email,
      //   'uid': user.user!.uid,

      // }, SetOptions(merge: true));
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
        'friends': [],
        'Image': '',
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

  Future<String> uploadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);

      Reference firebaseStoreRef =
          FirebaseStorage.instance.ref().child("$userId/PP/${userId}_photo");
      await firebaseStoreRef.putFile(imageFile);
      String url = await firebaseStoreRef.getDownloadURL();
      await _firestore.collection('users').doc(userId).update({'Image': url});
      return url;
    } catch (e) {
      //  log(e.toString());
      rethrow;
    }
  }
  //upLoad picture\
}
