import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up User
  Future<String> signupUser(
      {required String email,
      required String password,
      required Uint8List photo,
      required String username}) async {
    String res = "An error has occured";
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  // Log in User
  Future<String> loginUser(String email, String password) async {
    String res = "An error occured";
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signoutUser() async {
    await _auth.signOut();
  }
}
