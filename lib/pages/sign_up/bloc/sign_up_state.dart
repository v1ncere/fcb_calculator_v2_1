part of 'sign_up_bloc.dart';

class SignUpState extends Equatable with FormzMixin {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.mobileNumber = const MobileNumber.pure(),
    this.employeeId = const TextInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.obscurePassword = true,
    this.obscureConfirmPassword = true
  });
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final MobileNumber mobileNumber;
  final TextInput employeeId;
  final FormzSubmissionStatus status;
  final String message;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    MobileNumber? mobileNumber,
    TextInput? employeeId,
    FormzSubmissionStatus? status,
    String? message,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      employeeId: employeeId ?? this.employeeId,
      status: status ?? this.status,
      message: message ?? this.message,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword
    );
  } 

  @override
  List<Object> get props => [
    email, 
    password, 
    confirmPassword, 
    mobileNumber, 
    employeeId, 
    status,
    message,
    obscurePassword,
    obscureConfirmPassword,
    isValid
  ];

  @override
  List<FormzInput> get inputs => [
    email,
    password,
    confirmPassword,
    mobileNumber,
    employeeId
  ];
}
