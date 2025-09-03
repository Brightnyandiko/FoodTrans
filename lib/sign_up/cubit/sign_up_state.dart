part of 'sign_up_cubit.dart';

// final class SignUpState extends Equatable {
//   const SignUpState() : this._();
//
//   const SignUpState._({
//     this.email = const Email.pure(),
//     this.password = const Password.pure(),
//     this.confirmedPassword = const ConfirmedPassword.pure(),
//     this.status = FormzSubmissionStatus.initial,
//     this.errorMessage,
//   });
//
//   final Email email;
//   final Password password;
//   final ConfirmedPassword confirmedPassword;
//   final FormzSubmissionStatus status;
//   final String? errorMessage;
//
//   SignUpState withEmail(String email) {
//     return SignUpState._(
//       email: Email.dirty(email),
//       password: password,
//       confirmedPassword: confirmedPassword,
//     );
//   }
//
//   SignUpState withPassword(String password) {
//     return SignUpState._(
//       email: email,
//       password: Password.dirty(password),
//       confirmedPassword: ConfirmedPassword.dirty(
//         password: password,
//         value: confirmedPassword.value,
//       ),
//     );
//   }
//
//   SignUpState withConfirmedPassword(String confirmedPassword) {
//     return SignUpState._(
//       email: email,
//       password: password,
//       confirmedPassword: ConfirmedPassword.dirty(
//         password: password.value,
//         value: confirmedPassword,
//       ),
//     );
//   }
//
//   SignUpState withSubmissionInProgress() {
//     return SignUpState._(
//       email: email,
//       password: password,
//       confirmedPassword: confirmedPassword,
//       status: FormzSubmissionStatus.inProgress,
//     );
//   }
//
//   SignUpState withSubmissionSuccess() {
//     return SignUpState._(
//       email: email,
//       password: password,
//       confirmedPassword: confirmedPassword,
//       status: FormzSubmissionStatus.success,
//     );
//   }
//
//   SignUpState withSubmissionFailure([String? error]) {
//     return SignUpState._(
//       email: email,
//       password: password,
//       confirmedPassword: confirmedPassword,
//       status: FormzSubmissionStatus.failure,
//       errorMessage: error,
//     );
//   }
//
//   bool get isValid => Formz.validate([email, password, confirmedPassword]);
//
//   @override
//   List<Object?> get props => [
//     email,
//     password,
//     confirmedPassword,
//     status,
//     errorMessage,
//   ];
// }

final class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  SignUpState withEmail(String email) {
    return SignUpState(
      email: Email.dirty(email),
      password: password,
      confirmedPassword: confirmedPassword,
      status: status,
      errorMessage: errorMessage,
    );
  }

  // SignUpState withPassword(String password) {
  //   return SignUpState(
  //     email: email,
  //     password: Password.dirty(password),
  //     confirmedPassword: ConfirmedPassword.dirty(
  //       password: password,
  //       value: confirmedPassword.value,
  //     ),
  //     status: status,
  //     errorMessage: errorMessage,
  //   );
  // }

  SignUpState withPassword(String password) {
    print("withPassword called with: '$password'");
    final newPasswordField = Password.dirty(password);
    print("New password field created, isValid: ${newPasswordField.isValid}");

    return SignUpState(
      email: email,
      password: newPasswordField,
      confirmedPassword: confirmedPassword,
      status: status,
      errorMessage: errorMessage,
    );
  }

  SignUpState withConfirmedPassword(String confirmedPassword) {
    return SignUpState(
      email: email,
      password: password,
      confirmedPassword: ConfirmedPassword.dirty(
        password: password.value,
        value: confirmedPassword,
      ),
      status: status,
      errorMessage: errorMessage,
    );
  }

  SignUpState withSubmissionInProgress() {
    return SignUpState(
      email: email,
      password: password,
      confirmedPassword: confirmedPassword,
      status: FormzSubmissionStatus.inProgress,
      errorMessage: errorMessage,
    );
  }

  SignUpState withSubmissionSuccess() {
    return SignUpState(
      email: email,
      password: password,
      confirmedPassword: confirmedPassword,
      status: FormzSubmissionStatus.success,
      errorMessage: null,
    );
  }

  SignUpState withSubmissionFailure([String? error]) {
    return SignUpState(
      email: email,
      password: password,
      confirmedPassword: confirmedPassword,
      status: FormzSubmissionStatus.failure,
      errorMessage: error ?? 'Sign up failed',
    );
  }

  bool get isValid => Formz.validate([email, password, confirmedPassword]);

  @override
  List<Object?> get props => [
    email,
    password,
    confirmedPassword,
    status,
    errorMessage,
  ];
}