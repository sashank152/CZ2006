import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trashtogether/Screens/LoginScreen.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
