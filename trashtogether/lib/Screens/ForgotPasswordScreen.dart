import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trashtogether/Screens/LoginScreen.dart';
import 'package:trashtogether/Screens/MainScreen.dart';
import 'package:trashtogether/Screens/SignupScreen.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:trashtogether/widgets/TextInputField.dart';
import '../resources/AuthMethods.dart';
import '../utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  void forgotpassword() async {
    String res =
        await AuthMethods().forgotPassword(email: _emailController.text);
    if (res != "Success") {
      showSnackBar(res, context);
    } else {
      showSnackBar(
          "An email has been sent to your email account. Please check the junk/spam folder",
          context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/login.png"), fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .1),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .15,
                ),
                const Text(
                  'Please enter your email to reset your password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .33,
                ),
                TextInputField(
                  controller: _emailController,
                  hintText: "Email",
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
                GestureDetector(
                  onTap: forgotpassword,
                  child: Container(
                    child: isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      color: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
