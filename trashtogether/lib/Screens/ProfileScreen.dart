import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashtogether/Screens/LoginScreen.dart';
import 'package:trashtogether/Screens/changeUserNameScreen.dart';
import 'package:trashtogether/resources/AuthMethods.dart';
import 'package:trashtogether/utils/colors.dart';
import 'package:trashtogether/utils/utils.dart';
import 'package:trashtogether/Screens/changePasswordScreen.dart';

import 'MainScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: 6 10 49
    super.initState();

    getData();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  late String currentuid;
  late String photourl;
  late String username;
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      currentuid = _auth.currentUser!.uid;
      print(currentuid);

      DocumentSnapshot usersnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentuid)
          .get();
      var userData = usersnap.data() as Map<dynamic, dynamic>;

      photourl = userData['photoURL'];
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  void signOutUser() async {
    String res = await AuthMethods().signOutUser();
    if (res != "Success") {
      showSnackBar(res, context);
    } else {
      showSnackBar("Successfully Signed Out", context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
              centerTitle: true,
              backgroundColor: fieldColor,
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(photourl), fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => changeUserNameScreen())),
                    child: Container(
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : const Text(
                              'Reset UserName',
                              style: TextStyle(color: Colors.white),
                            ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        color: darkgreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.075,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => changePasswordScreen())),
                    child: Container(
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : const Text(
                              'Reset Password',
                              style: TextStyle(color: Colors.white),
                            ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        color: darkgreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  GestureDetector(
                    onTap: signOutUser,
                    child: Container(
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : const Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.white),
                            ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        color: darkgreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
