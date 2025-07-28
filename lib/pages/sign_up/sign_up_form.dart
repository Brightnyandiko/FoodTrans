import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_trans/login/cubit/login_cubit.dart';
import 'package:formz/formz.dart';

import '../../sign_up/cubit/sign_up_cubit.dart';
import '../login/login_page.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const SizedBox(height: 30),
            _PasswordInput(),
            const SizedBox(height: 20),
            _ConfirmPasswordInput(),
            const SizedBox(height: 10),
            _SignUpButton(),
            const SizedBox(height: 15,),
            _GoogleSignInButton(),
            const SizedBox(height: 10,),
            _SignInButton()
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
          (SignUpCubit cubit) => cubit.state.email.displayError,
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
              onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
          (SignUpCubit cubit) => cubit.state.password.displayError,
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
                  context.read<SignUpCubit>().passwordChanged(password),
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
          (SignUpCubit cubit) => cubit.state.confirmedPassword.displayError,
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
                  context.read<SignUpCubit>().confirmedPasswordChanged(password),
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Enter Password",
                  helperText: '',
                  errorText: displayError != null ? 'passwords do not march' : null,
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

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
          (SignUpCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
          (SignUpCubit cubit) => cubit.state.isValid,
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
            ? () => context.read<SignUpCubit>().signUpFormSubmitted()
            : null,
        // color: Colors.deepOrangeAccent,
        // textColor: Colors.white,
        child: Text("Sign in", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
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

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Dont have an account?"),

        const SizedBox(width: 2,),

        MaterialButton(
          onPressed: () => Navigator.of(context).pushNamed("login_page.dart"),
          child: Text("Register"),
        )
      ],
    );
  }
}
