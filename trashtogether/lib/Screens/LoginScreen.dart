import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trashtogether/Screens/MainScreen.dart';
import 'package:trashtogether/Screens/SignupScreen.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:trashtogether/widgets/TextInputField.dart';
import '../resources/AuthMethods.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res != "Success") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()));
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
                  'Trash Together',
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
                const SizedBox(
                  height: 15,
                ),
                TextInputField(
                  controller: _passwordController,
                  hintText: "Password",
                  inputType: TextInputType.text,
                  isPassword: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: textColor),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                GestureDetector(
                  onTap: loginUser,
                  child: Container(
                    child: isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : const Text(
                            'Sign in',
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
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text('Dont have an account?'),
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * .05),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignupScreen())),
                      child: Container(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * .05),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
