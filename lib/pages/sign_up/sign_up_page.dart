import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_trans/pages/sign_up/sign_up_form.dart';

import '../../sign_up/cubit/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
        child: Container(
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

              SignUpForm()

            ],
          ),
        ),
      ),
    );
  }
}
