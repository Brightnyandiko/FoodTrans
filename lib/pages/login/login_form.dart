import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_trans/login/cubit/login_cubit.dart';
import 'package:formz/formz.dart';

import '../sign_up/sign_up_page.dart';
import 'login_page.dart';

// import '../sign_up/sign_up_page.dart';
// import '../signup/sign_up_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              _EmailInput(),
              const SizedBox(height: 20),
              _PasswordInput(),
              const SizedBox(height: 10),
              _LoginButton(),
              const SizedBox(height: 15),
              _GoogleLoginButton(),
              const SizedBox(height: 10),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
          (LoginCubit cubit) => cubit.state.email.displayError,
    );

    return Container(
      margin: EdgeInsets.only(right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

          const SizedBox(height: 10,),

          TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Enter Email",
                  helperText: '',
                  errorText: displayError != null ? 'invalid email' : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                  )
              )
          )
        ],
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
          (LoginCubit cubit) => cubit.state.password.displayError,
    );

    return Container(
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
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Enter Password",
                  helperText: '',
                  errorText: displayError != null ? 'invalid password' : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              )
          )
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
          (LoginCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
          (LoginCubit cubit) => cubit.state.isValid,
    );

    return Container(
      margin: EdgeInsets.only(left: 17),
      width: 300,
      height: 50,
      child: ElevatedButton(
        key: const Key('loginForm_continue_raisedButton'),
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.deepOrangeAccent)
        ),
        onPressed: isValid
            ? () => context.read<LoginCubit>().logInWithCredentials()
            : null,
        // color: Colors.deepOrangeAccent,
        // textColor: Colors.white,
        child: Text("Sign in", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('loginForm_googleLogin_raisedButton'),
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
            icon: Icon(FontAwesomeIcons.google, color: Colors.grey,)
        )
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Dont have an account?"),

        const SizedBox(width: 2,),

        MaterialButton(
          onPressed: () => Navigator.of(context).pushNamed("sign_up_page.dart"),
          child: Text("Register"),
        )
      ],
    );
  }
}