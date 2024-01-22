import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/repository/repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required FirebaseAuthRepository authRepository
  }) :  _authRepository = authRepository,
  super(const ForgotPasswordState()) {
    on<EmailInputChanged>(_onEmailInputChanged);
    on<RequestSubmitted>(_onRequestSubmitted);
  }
  final FirebaseAuthRepository _authRepository;

  void _onEmailInputChanged(EmailInputChanged event, Emitter<ForgotPasswordState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onRequestSubmitted(RequestSubmitted event, Emitter<ForgotPasswordState> emit) async {
    if(state.isValid) {
      try {
        await _authRepository.requestResetPassword(email: state.email.value);
        emit(state.copyWith(status: FormzSubmissionStatus.success, message: "Password reset email sent. Please check your inbox."));
      } on RequestResetPasswordFailure catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
      }
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Oops! Something went wrong.'));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
}
