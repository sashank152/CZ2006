import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trashtogether/Screens/LoginScreen.dart';
import 'package:trashtogether/Screens/MainScreen.dart';
import 'package:trashtogether/Screens/ProfileScreen.dart';
import 'package:trashtogether/Screens/SignupScreen.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:trashtogether/widgets/TextInputField.dart';
import '../resources/AuthMethods.dart';
import '../utils/utils.dart';

class changePasswordScreen extends StatefulWidget {
  changePasswordScreen({Key? key}) : super(key: key);

  @override
  State<changePasswordScreen> createState() => _changePasswordScreenState();
}

class _changePasswordScreenState extends State<changePasswordScreen> {
  final TextEditingController _currentpasswordController =
      TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmnewpasswordController =
      TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _currentpasswordController.dispose();
    _newpasswordController.dispose();
    _confirmnewpasswordController.dispose();
  }

  void changePassword() async {
    String res = await AuthMethods().changePassword(
        _currentpasswordController.text,
        _newpasswordController.text,
        _confirmnewpasswordController.text);
    if (res != "success") {
      showSnackBar(res, context);
    } else {
      showSnackBar("Password has been changed", context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfileScreen()));
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
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .15,
                      ),
                      const Text(
                        'Change Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .33,
                      ),
                      TextInputField(
                        controller: _currentpasswordController,
                        hintText: "Enter Old Password",
                        inputType: TextInputType.text,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      TextInputField(
                        controller: _newpasswordController,
                        hintText: "Enter new Password",
                        inputType: TextInputType.text,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      TextInputField(
                        controller: _confirmnewpasswordController,
                        hintText: "Confirm new Password",
                        inputType: TextInputType.text,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      GestureDetector(
                        onTap: changePassword,
                        child: Container(
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white))
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
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
          ),
        ],
      ),
    );
  }
}
