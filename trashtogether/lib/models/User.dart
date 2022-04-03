import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final double cash;
  final String uid;
  final String photoURL;

  const User(
      {required this.email,
      required this.cash,
      required this.photoURL,
      required this.username,
      required this.uid});

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'uid': uid,
        'photoURL': photoURL,
        'cash': cash,
      };

  static User modelFromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        cash: snapshot['cash'] ?? 0.0,
        email: snapshot['email'],
        uid: snapshot['uid'],
        photoURL: snapshot['photoURL'] ?? '',
        username: snapshot['username']);
  }
}
