import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 18, top: 50),
        child: Column(
          children: [
            Text(
              "Login to your\naccount",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.black),
            ),
            const SizedBox(height: 10,),
            Text("Please Sign in to your account")
          ],
        ),
      ),
    );
  }
}
