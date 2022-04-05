import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trashtogether/resources/storageMethods.dart';
import 'package:trashtogether/models/User.dart' as model;
import 'package:trashtogether/Screens/verifyEmailScreen.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isemailVerified = false;
  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          file != null) {
        //register user
        if (password.length >= 16 || password.length < 6) {
          res = "Password must be between 6-16 characters";
          return res;
        }
        String formatter = email.split('@')[0];
        if (formatter.contains('.') ||
            formatter.contains('@') ||
            formatter.contains(',') ||
            formatter.contains('/') ||
            formatter.contains('\'') ||
            formatter.contains(';')) {
          res = "Invalid Email";
          return res;
        }
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoURL =
            await StorageMethods().uploadImage('profilepics', file);

        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            cash: 0.0,
            photoURL: photoURL);

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      } else if (email.isEmpty) {
        res = "Email cannot be empty";
        return res;
      } else if (password.isEmpty) {
        res = "Password cannot be empty";
        return res;
      } else if (username.isEmpty) {
        res = "Username cannot be empty";
        return res;
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
    String res = "Email or password cannot be empty";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else if (email.isEmpty) {
        res = "Email cannot be empty";
        return res;
      } else if (password.isEmpty) {
        res = "Password cannot be empty";
        return res;
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
  Future<String> changePassword(String currentPassword, String newPassword,
      String confirmnewPassword) async {
    String res = "error";
    if (newPassword != confirmnewPassword) {
      res = "Confirm password is not equal to your new password";
      return res;
    }
    if (currentPassword == newPassword) {
      res = "New Password Cannot Be The Same As Your Old Password";
      return res;
    }
    User? currentuser = _auth.currentUser;
    try {
      await currentuser?.updatePassword(newPassword);
      res = "success";
    } on FirebaseAuthException catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> changeDisplayname(
      String newDisplayName, String currentDisplayName) async {
    String res = "error";
    if (newDisplayName == currentDisplayName) {
      res = "New Username Cannot Be The Same As The Old Username";
      return res;
    }
    try {
      String currentuid = _auth.currentUser!.uid;
      DocumentSnapshot usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentuid)
          .get();
      var userData = usersnap.data() as Map<dynamic, dynamic>;
      userData['username'] = newDisplayName;

      await _firestore
          .collection('users')
          .doc(currentuid)
          .set(userData as Map<String, dynamic>);
      res = "Success";
    } on FirebaseAuthException catch (e) {
      res = e.toString();
    }

    // User? currentuser = _auth.currentUser;
    // try {
    //   await currentuser?.updateDisplayName(newDisplayName);
    //   res = "success";
    // } on FirebaseAuthException catch (e) {
    //   res = e.toString();
    // }
    return res;
  }

  Future<String> forgotPassword({required String email}) async {
    String res = "error";
    try {
      await _auth.sendPasswordResetEmail(email: email);
      res = "Success";
    } on FirebaseAuthException catch (e) {
      res = e.toString();
    }
    return res;
  }
}
