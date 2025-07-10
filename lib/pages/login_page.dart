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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login to your\naccount",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.black),
            ),
            const SizedBox(height: 10,),

            Text("Please Sign in to your account"),

             const SizedBox(height: 30,),

            Container(
              margin: EdgeInsets.only(right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Address",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

                  const SizedBox(height: 10,),

                  TextField(
                    decoration: InputDecoration(
                        hintText: "Enter Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    )
                  )
                ],
              ),
            ),

            const SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

                  const SizedBox(height: 10,),

                  TextField(
                      decoration: InputDecoration(
                          hintText: "Enter Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      )
                  )
                ],
              ),
            ),

            const SizedBox(height: 10,),

            Container(
              margin: EdgeInsets.only(right: 5),
              child: MaterialButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot password?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15,),

            Container(
              margin: EdgeInsets.only(left: 17),
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.deepOrangeAccent)
                ),
                onPressed: () {},
                // color: Colors.deepOrangeAccent,
                // textColor: Colors.white,
                child: Text("Sign in", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
