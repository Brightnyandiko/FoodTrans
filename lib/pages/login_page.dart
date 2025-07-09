import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 50),
        child: Row(
          children: [
            Text(
              "Login to your\naccount", 
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
            Text("Please Sign in to your account")
          ],
        ),
      ),
    );
  }
}
