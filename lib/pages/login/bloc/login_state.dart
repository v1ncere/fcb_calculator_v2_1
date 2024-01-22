part of 'login_bloc.dart';

class LoginState extends Equatable with FormzMixin {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.isObscure = true
  });
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final String message;
  final bool isObscure;

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    String? message,
    bool? isObscure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
      isObscure: isObscure ?? this.isObscure,
    );
  }
  
  @override
  List<Object> get props => [email, password, status, message, isObscure, isValid];

  @override
  List<FormzInput> get inputs => [email, password];
}
