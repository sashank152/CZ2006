import 'package:flutter/material.dart';
import 'package:trashtogether/Screens/MainScreen.dart';
import 'package:trashtogether/Screens/SignupScreen.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:trashtogether/widgets/TextInputField.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = new TextEditingController();
  bool isLoading = false;
  final TextEditingController _passwordController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('images/LoginScreenImage.jpg'),
            const SizedBox(
              height: 15,
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
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MainScreen())),
              child: Container(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : const Text('Log in'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text("Forgot Password?"),
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen())),
                  child: Container(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
