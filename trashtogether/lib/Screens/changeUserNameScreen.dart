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

class changeUserNameScreen extends StatefulWidget {
  changeUserNameScreen({Key? key}) : super(key: key);

  @override
  State<changeUserNameScreen> createState() => _changeUserNameScreenState();
}

class _changeUserNameScreenState extends State<changeUserNameScreen> {
  final TextEditingController _currentusernameController =
      TextEditingController();
  final TextEditingController _newusernameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _currentusernameController.dispose();
    _newusernameController.dispose();
  }

  void changeUserName() async {
    String res = await AuthMethods().changeDisplayname(
        _newusernameController.text, _currentusernameController.text);
    if (res != "Success") {
      showSnackBar(res, context);
    } else {
      showSnackBar("Username has been changed", context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
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
                        'Change Username',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .33,
                      ),
                      TextInputField(
                        controller: _currentusernameController,
                        hintText: "Enter Old Username",
                        inputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      TextInputField(
                        controller: _newusernameController,
                        hintText: "Enter New Username",
                        inputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      GestureDetector(
                        onTap: changeUserName,
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
