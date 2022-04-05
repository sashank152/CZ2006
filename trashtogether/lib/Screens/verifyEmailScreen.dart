import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:trashtogether/Screens/LoginScreen.dart';
import 'package:trashtogether/Screens/MainScreen.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashtogether/widgets/TextInputField.dart';
import 'package:trashtogether/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../resources/AuthMethods.dart';

class verifyEmailScreen extends StatefulWidget {
  const verifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<verifyEmailScreen> createState() => _verifyEmailScreenState();
}

class _verifyEmailScreenState extends State<verifyEmailScreen> {
  Timer? timer;
  final auth = FirebaseAuth.instance;
  User? user;
  bool isVerified = false;

  @override
  void initState() {
    user = auth.currentUser;
    user?.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
              'An email has been sent to ${auth.currentUser!.email} please verify')),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user?.reload();
    isVerified = user!.emailVerified;
    if (isVerified) {
      showSnackBar(
          "Email Has been Successfully Verified. Please Login using your new account.",
          context);
      timer?.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
