import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    return emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

// enum PasswordValidationError { empty, tooShort }
//
// class Password extends FormzInput<String, PasswordValidationError> {
//   const Password.pure() : super.pure('');
//   const Password.dirty([String value = '']) : super.dirty(value);
//
//   @override
//   PasswordValidationError? validator(String value) {
//     if (value.isEmpty) return PasswordValidationError.empty;
//     return value.length >= 6 ? null : PasswordValidationError.tooShort;
//   }
// }

enum PasswordValidationError { empty, tooShort, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < 6) return PasswordValidationError.tooShort;

    // More permissive regex - allows any printable characters
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$');
    if (!passwordRegex.hasMatch(value)) return PasswordValidationError.invalid;

    return null;
  }
}

enum ConfirmedPasswordValidationError { empty, mismatch }

class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordValidationError> {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmedPassword.dirty({required this.password, String value = ''}) : super.dirty(value);

  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    if (value.isEmpty) return ConfirmedPasswordValidationError.empty;
    return password == value ? null : ConfirmedPasswordValidationError.mismatch;
  }
}