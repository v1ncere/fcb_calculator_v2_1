import 'package:formz/formz.dart';

class TextInput extends FormzInput<String, TextInputValidationError> {
  const TextInput.pure() : super.pure('');
  const TextInput.dirty([super.value = '']) : super.dirty();

  static final _regexp = RegExp("[a-zA-Z0-9]");

  @override
  TextInputValidationError? validator(String? value) {
    return value?.isEmpty == true
    ? TextInputValidationError.required
    : _regexp.hasMatch(value!)
      ? null
      : TextInputValidationError.invalid;
  }
}

enum TextInputValidationError { required, invalid }

extension TextInputValidationErrorX on TextInputValidationError {
  String text() {
    switch(this) {
      case TextInputValidationError.required:
        return 'Inputs is required';
      case TextInputValidationError.invalid:
        return 'The input is invalid. Please try again.';
    }
  }
}
