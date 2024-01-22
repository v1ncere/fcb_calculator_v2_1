part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable with FormzMixin {
  const ForgotPasswordState({
    this.email = const Email.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final Email email;
  final FormzSubmissionStatus status;
  final String message;

  ForgotPasswordState copyWith({
    Email? email,
    FormzSubmissionStatus? status,
    String? message,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [email, message, status, isValid];
  
  @override
  List<FormzInput> get inputs => [email];
}
