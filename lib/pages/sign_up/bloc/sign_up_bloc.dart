import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/repository/repository.dart';
import 'package:fcb_calculator_v2_1/utils/init_device_info_plugin.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required FirebaseAuthRepository authRepository,
    required FirebaseDatabaseRepository databaseRepository,
  })  : _authRepository = authRepository,
  _databaseRepository = databaseRepository,
  super(const SignUpState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<EmployeeIdChanged>(_onEmployeeIdChanged);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<PasswordTextObscured>(_onPasswordTextObscured);
    on<ConfirmPasswordTextObscured>(_onConfirmPasswordTextObscured);
  }
  final FirebaseAuthRepository _authRepository;
  final FirebaseDatabaseRepository _databaseRepository;

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    final confirm = ConfirmPassword.dirty(password: state.password.value, value: event.confirmPassword);
    emit(state.copyWith(confirmPassword: confirm));
  }

  void _onEmployeeIdChanged(EmployeeIdChanged event, Emitter<SignUpState> emit) {
    final id = TextInput.dirty(event.employeeId);
    emit(state.copyWith(employeeId: id));
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<SignUpState> emit) {
    final mobileNumber = MobileNumber.dirty(event.mobileNumber);
    emit(state.copyWith(mobileNumber: mobileNumber));
  }

  void _onPasswordTextObscured(PasswordTextObscured event, Emitter<SignUpState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordTextObscured(ConfirmPasswordTextObscured event, Emitter<SignUpState> emit) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void _onSignUpSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final now = DateTime.now();
        final phone = await initDeviceInfoPlugin();
        final auth = await _authRepository.signUpWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );
        if (auth != null) {
          await _databaseRepository.addUsers(
            auth.user!.uid,
            Users(
              email: state.email.value.trim(),
              employeeId: state.employeeId.value.trim(),
              phoneId: phone,
              mobileNumber: int.parse(state.mobileNumber.value.replaceAll(RegExp(r'[\(\) +]'), '')),
              expiry: now,
              createdAt: now,
              updatedAt: now
            )
          );
          _authRepository.verifyEmail();
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        }
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: "Error: ${e.toString().replaceAll("Exception: ", "")}"));
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
