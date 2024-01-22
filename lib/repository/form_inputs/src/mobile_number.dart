import 'package:formz/formz.dart';

class MobileNumber extends FormzInput<String, MobileNumberValidationError> {
  const MobileNumber.pure() : super.pure('');
  const MobileNumber.dirty([super.value = '']) : super.dirty();

  static final _mobileRegExp = RegExp(r'(^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$)');

  @override
  MobileNumberValidationError? validator(String? value) {
    return value?.isEmpty == true
    ? MobileNumberValidationError.required
    : _mobileRegExp.hasMatch(value!)
      ? null
      : MobileNumberValidationError.invalid;
  }
}

enum MobileNumberValidationError { required, invalid }

extension MobileNumberValidationErrorX on MobileNumberValidationError {
  String text() {
    switch(this) {
      case MobileNumberValidationError.required:
        return 'Mobile number is required.';
      case MobileNumberValidationError.invalid:
        return 'This mobile number is invalid. Please try again.';
    }
  }
}