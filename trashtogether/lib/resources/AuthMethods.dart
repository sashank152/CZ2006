import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trashtogether/resources/storageMethods.dart';
import 'package:trashtogether/models/User.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl =
            await StorageMethods().uploadImage('profilepics', file);

        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            cash: 0.0,
            photoURL: photoUrl);

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "Successfully signed up!!!";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res =
            "The email is badly formatted!!! Please enter an email in the format xxx@xxx.com";
      } else if (err.code == "weak-password") {
        res = "Password should be at least 6 characters long";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Email or Password cannot be empty";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = "User does not exist";
      } else if (e.code == 'wrong-password') {
        res = "Wrong password";
      }
    }
    return res;
  }

  Future<String> signOutUser() async {
    String res = "Some error occurred";
    try {
      await _auth.signOut();
      res = "Success";
    } on FirebaseAuthException catch (e) {
      res = e.toString();
      // An error happened.
    }
    return res;
  }

  // Sign-out successful.
  Future<String> changePassword(
      String currentPassword, String newPassword) async {
    String res = "error";
    User? currentuser = _auth.currentUser;
    try {
      await currentuser?.updatePassword(newPassword);
      res = "success";
    } on FirebaseAuthException catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> changeDisplayname(String newDisplayName) async {
    String res = "error";
    User? currentuser = _auth.currentUser;
    try {
      await currentuser?.updateDisplayName(newDisplayName);
      res = "success";
    } on FirebaseAuthException catch (e) {
      res = e.toString();
    }
    return res;
  }
}
