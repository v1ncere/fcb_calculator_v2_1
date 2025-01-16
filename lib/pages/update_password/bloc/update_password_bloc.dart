import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/repository/repository.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordBloc() : super(const UpdatePasswordState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ConfirmNewPasswordChanged>(_onConfirmNewPasswordChanged);
    on<PasswordObscured>(_onPasswordObscured);
    on<NewPasswordObscured>(_onNewPasswordObscured);
    on<ConfirmNewPasswordObscured>(_onConfirmNewPasswordObscured);
    on<PasswordUpdateSubmitted>(_onPasswordUpdateSubmitted);
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<UpdatePasswordState> emit) {
    final currentPassword = Password.dirty(event.currentPassword);
    emit(state.copyWith(currentPassword: currentPassword));
  }

  void _onNewPasswordChanged(NewPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    final newPassword = Password.dirty(event.newPassword);
    emit(state.copyWith(newPassword: newPassword));
  }

  void _onConfirmNewPasswordChanged(ConfirmNewPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    final confirmPassword = ConfirmPassword.dirty(password: state.newPassword.value, value: event.confirmPassword);
    emit(state.copyWith(confirmNewPassword: confirmPassword));
  }

  void _onPasswordObscured(PasswordObscured event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  void _onNewPasswordObscured(NewPasswordObscured event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isNewPasswordObscure: !state.isNewPasswordObscure));
  }

  void _onConfirmNewPasswordObscured(ConfirmNewPasswordObscured event, Emitter<UpdatePasswordState> emit) {
    emit(state.copyWith(isConfirmNewPasswordObscure: !state.isConfirmNewPasswordObscure));
  }

  void _onPasswordUpdateSubmitted(PasswordUpdateSubmitted event, Emitter<UpdatePasswordState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final user = FirebaseAuth.instance.currentUser!;
        final cred = EmailAuthProvider.credential(email: user.email!, password: state.currentPassword.value);

        await user.reauthenticateWithCredential(cred).then((value) async {
          await user.updatePassword(state.newPassword.value).then((_) {
            emit(state.copyWith(status: FormzSubmissionStatus.success));
          }).onError((error, stackTrace) {
            emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              message: "Error: ${error.toString().replaceAll('Exception: ', "")}"
            ));
          });
        }).onError((error, stackTrace) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            message: "Error: ${error.toString().replaceAll('Exception: ', "")}"
          ));
        });
      } catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          message: "Error: ${e.toString().replaceAll('Exception: ', "")}"
        ));
      }
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        message: 'Oops! It looks like you missed some required fields. Please make sure to complete all the fields before submitting your form. Thank you!'
      ));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
}

