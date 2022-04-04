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

import '../resources/AuthMethods.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isloading = false;
  Uint8List? image;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() => image = im);
  }

  void signUpUser() async {
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        file: image!);
    if (res != "sucess") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/registration.png"),
                fit: BoxFit.cover)),
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              const Text(
                'Welcome to Trash Together',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Sign up for an account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1541701494587-cb58502866ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () => selectImage(),
                      icon: const Icon(Icons.add_a_photo),
                      color: buttonColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextInputField(
                  hintText: 'Username',
                  controller: _usernameController,
                  inputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                  hintText: 'Email',
                  controller: _emailController,
                  inputType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                hintText: 'Password',
                controller: _passwordController,
                inputType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: signUpUser,
                child: Material(
                  child: Container(
                    child: isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : const Text(
                            'Sign Up',
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
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text('Already have an account?'),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                    child: Container(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
