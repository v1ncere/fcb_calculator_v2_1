part of 'update_password_bloc.dart';

sealed class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

final class PasswordChanged extends UpdatePasswordEvent {
  const PasswordChanged(this.currentPassword);
  final String currentPassword;

  @override
  List<Object> get props => [currentPassword];
}

final class NewPasswordChanged extends UpdatePasswordEvent {
  const NewPasswordChanged(this.newPassword);
  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

final class ConfirmNewPasswordChanged extends UpdatePasswordEvent {
  const ConfirmNewPasswordChanged(this.confirmPassword);
  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

final class PasswordObscured extends UpdatePasswordEvent {}

final class NewPasswordObscured extends UpdatePasswordEvent {}

final class ConfirmNewPasswordObscured extends UpdatePasswordEvent {}

final class PasswordUpdateSubmitted extends UpdatePasswordEvent {}
