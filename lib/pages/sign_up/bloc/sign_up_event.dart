part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class EmailChanged extends SignUpEvent {
  const EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class PasswordChanged extends SignUpEvent {
  const PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class ConfirmPasswordChanged extends SignUpEvent {
  const ConfirmPasswordChanged(this.confirmPassword);
  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

final class EmployeeIdChanged extends SignUpEvent {
  const EmployeeIdChanged(this.employeeId);
  final String employeeId;

  @override
  List<Object> get props => [employeeId];
}

final class MobileNumberChanged extends SignUpEvent {
  const MobileNumberChanged(this.mobileNumber);
  final String mobileNumber;

  @override
  List<Object> get props => [mobileNumber];
}

final class PasswordTextObscured extends SignUpEvent {}

final class ConfirmPasswordTextObscured extends SignUpEvent {}

final class SignUpSubmitted extends SignUpEvent {}