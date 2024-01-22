part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

final class EmailInputChanged extends ForgotPasswordEvent {
  const EmailInputChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class RequestSubmitted extends ForgotPasswordEvent {}