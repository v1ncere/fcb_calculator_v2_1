part of 'update_password_bloc.dart';

class UpdatePasswordState extends Equatable with FormzMixin {
  const UpdatePasswordState({
    this.currentPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.confirmNewPassword = const ConfirmPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isPasswordObscure = true,
    this.isNewPasswordObscure = true,
    this.isConfirmNewPasswordObscure = true,
    this.message,
  });
  final Password currentPassword;
  final Password newPassword;
  final ConfirmPassword confirmNewPassword;
  final FormzSubmissionStatus status;
  final bool isPasswordObscure;
  final bool isNewPasswordObscure;
  final bool isConfirmNewPasswordObscure;
  final String? message;

  UpdatePasswordState copyWith({
    Password? currentPassword,
    Password? newPassword,
    ConfirmPassword? confirmNewPassword,
    FormzSubmissionStatus? status,
    bool? isPasswordObscure,
    bool? isNewPasswordObscure,
    bool? isConfirmNewPasswordObscure,
    String? message
  }) {
    return UpdatePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      status: status ?? this.status,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isNewPasswordObscure: isNewPasswordObscure ?? this.isNewPasswordObscure,
      isConfirmNewPasswordObscure: isConfirmNewPasswordObscure ?? this.isConfirmNewPasswordObscure,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object?> get props => [
    currentPassword,
    newPassword,
    confirmNewPassword,
    status,
    isPasswordObscure,
    isNewPasswordObscure,
    isConfirmNewPasswordObscure,
    message,
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [currentPassword, newPassword, confirmNewPassword];
}
