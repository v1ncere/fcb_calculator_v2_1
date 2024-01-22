import 'package:formz/formz.dart';

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({required this.password, String value = ''}) : super.dirty(value);
  final String password;

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    return value?.isEmpty == true
    ? ConfirmPasswordValidationError.required
    : password == value
      ? null
      : ConfirmPasswordValidationError.invalid;
  }
}

enum ConfirmPasswordValidationError { required, invalid }

extension ConfirmPasswordValidationErrorX on ConfirmPasswordValidationError {
  String text() {
    switch (this) {
      case ConfirmPasswordValidationError.required:
        return 'Confirm password is required';
      case ConfirmPasswordValidationError.invalid:
        return 'Confirm password not match. Please try again.';
    }
  }
}