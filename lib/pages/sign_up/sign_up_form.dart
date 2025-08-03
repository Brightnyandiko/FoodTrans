import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_trans/login/cubit/login_cubit.dart';
import 'package:formz/formz.dart';

import '../../sign_up/cubit/sign_up_cubit.dart';
import '../../util/sign_up_validation.dart';
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
            const SizedBox(height: 10,),
            _EmailInput(),
            const SizedBox(height: 5),
            _PasswordInput(),
            const SizedBox(height: 5),
            _ConfirmPasswordInput(),
            const SizedBox(height: 5),
            _SignUpButton(),
            const SizedBox(height: 5,),
            _GoogleSignInButton(),
            const SizedBox(height: 5,),
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

          // const SizedBox(height: 10,),

          TextField(
              key: const Key('signUpForm_emailInput_textField'),
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

// class _PasswordInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final displayError = context.select(
//           (SignUpCubit cubit) => cubit.state.password.displayError,
//     );
//
//     return Container(
//       margin: EdgeInsets.only(right: 18),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Password",
//             textAlign: TextAlign.start,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
//
//           // const SizedBox(height: 10,),
//
//           TextField(
//               key: const Key('signUpForm_passwordInput_textField'),
//               onChanged: (password) =>
//                   context.read<SignUpCubit>().passwordChanged(password),
//               obscureText: true,
//               decoration: InputDecoration(
//                   hintText: "Enter Password",
//                   helperText: '',
//                   errorText: displayError != null ? 'invalid password' : null,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)
//                   )
//               )
//           )
//         ],
//       ),
//     );
//   }
// }

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
          (SignUpCubit cubit) => cubit.state.password.displayError,

    // final displayError = context.select(
    //       (SignUpCubit cubit) {
    //     print("Selecting password error: ${cubit.state.password.displayError}");
    //     return cubit.state.password.displayError;
    //   },
    );

    return Container(
      margin: EdgeInsets.only(right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          TextField(
              key: const Key('signUpForm_passwordInput_textField'),
              onChanged: (password) {
                print("=== PASSWORD DEBUG ===");
                print("Entered password: '$password'");
                print("Password length: ${password.length}");

                context.read<SignUpCubit>().passwordChanged(password);

                final newState = context.read<SignUpCubit>().state;
                print("Password value in state: '${newState.password.value}'");
                print("Password isPure: ${newState.password.isPure}");
                print("Password isValid: ${newState.password.isValid}");
                print("Password displayError: ${newState.password.displayError}");
                print("========================");
              },

              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Enter Password",
                  helperText: '',
                  // Fix the error text logic
                  // errorText: displayError == PasswordValidationError.empty
                  //     ? 'Password is required'
                  //     : displayError == PasswordValidationError.tooShort
                  //     ? 'Password must be at least 6 characters'
                  //     : null,
                  errorText: displayError == PasswordValidationError.empty
                      ? 'Password is required'
                      : displayError == PasswordValidationError.tooShort
                      ? 'Password must be at least 6 characters'
                      : displayError == PasswordValidationError.invalid
                      ? 'Password must contain letters and numbers'  // Handle the invalid case
                      : null,
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

// class _ConfirmPasswordInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final displayError = context.select(
//           (SignUpCubit cubit) => cubit.state.confirmedPassword.displayError,
//     );
//
//     return Container(
//       margin: EdgeInsets.only(right: 18),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Confirm Password",
//             textAlign: TextAlign.start,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
//
//           // const SizedBox(height: 10,),
//
//           TextField(
//               key: const Key('signUpForm_confirmedPasswordInput_textField'),
//               onChanged: (password) =>
//                   context.read<SignUpCubit>().confirmedPasswordChanged(password),
//               obscureText: true,
//               decoration: InputDecoration(
//                   hintText: "Enter Password",
//                   helperText: '',
//                   errorText: displayError != null ? 'passwords do not march' : null,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)
//                   )
//               )
//           )
//         ],
//       ),
//     );
//   }
// }

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
            "Confirm Password",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          TextField(
              key: const Key('signUpForm_confirmedPasswordInput_textField'),
              onChanged: (password) =>
                  context.read<SignUpCubit>().confirmedPasswordChanged(password),
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Confirm Password", // Fixed hint text
                  helperText: '',
                  // Fix the error text logic
                  errorText: displayError == ConfirmedPasswordValidationError.empty
                      ? 'Please confirm your password'
                      : displayError == ConfirmedPasswordValidationError.mismatch
                      ? 'Passwords do not match'
                      : null,
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

    print("BTN STATE ::: $isValid");

    return Container(
      // margin: EdgeInsets.only(left: 17),
      width: 300,
      height: 50,
      child: ElevatedButton(
        key: const Key('signUpForm_continue_raisedButton'),
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.deepOrangeAccent)
        ),
        onPressed: isValid
            ? () => context.read<SignUpCubit>().signUpFormSubmitted()
            : null,

        // color: Colors.deepOrangeAccent,
        // textColor: Colors.white,
        child: Text("Sign up", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('loginForm_googleLogin_raisedButton'),
      mainAxisAlignment: MainAxisAlignment.center,
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
        Text("Already have an account?"),

        // const SizedBox(width: 2,),

        MaterialButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),

          child: Text("Sign In", style: TextStyle(color: Colors.deepOrangeAccent),),
        )
      ],
    );
  }
}
