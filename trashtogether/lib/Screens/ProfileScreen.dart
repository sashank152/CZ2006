import 'package:flutter/material.dart';
import 'package:trashtogether/Screens/LoginScreen.dart';
import 'package:trashtogether/resources/AuthMethods.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Username"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1594897030264-ab7d87efc473?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8c3BsYXNofGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
            ),
            Divider(),
            Text("UserName"),
            TextButton(onPressed: () {}, child: Text("Change Username")),
            TextButton(onPressed: () {}, child: Text("Change Password")),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            TextButton(
                onPressed: () async {
                  await AuthMethods().signoutUser();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text("Log out"))
          ],
        ),
      ),
    );
  }
}
