import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:fcb_calculator_v2_1/repository/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required FirebaseAuthRepository authRepository,
    required FirebaseDatabaseRepository databaseRepository,
  }) : _authRepository = authRepository, _databaseRepository = databaseRepository,
  super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoggedInWithCredentials>(_onLoggedInWithCredentials);
    on<PasswordObscured>(_onPasswordObscured);
  }
  final FirebaseAuthRepository _authRepository;
  final FirebaseDatabaseRepository _databaseRepository;

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onPasswordObscured(PasswordObscured event, Emitter<LoginState> emit) {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void _onLoggedInWithCredentials(LoggedInWithCredentials event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final credential = await _authRepository.logInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value
        );

        if (credential != null && credential.user!.emailVerified != true) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            message: "Please verify your email address to continue. We've sent a verification link to your email.",
          ));
        } else if (credential != null && !_isUserNotExpired(await _getCurrentUser(credential.user!.uid))) {
          emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              message: 'Access Limit Reached. Contact Admin for Renewal.',
          ));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        }
      } on LogInWithEmailAndPasswordFailure catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
      }
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure, 
        message: 'Oops! It looks like you missed some required fields. Please make sure to complete all the fields before submitting your form. Thank you!'
      ));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
  
  // get current user
  Future<Users> _getCurrentUser(String uid) async => _databaseRepository.getUsers(uid);
  // check user expiry
  bool _isUserNotExpired(Users currentUser) => currentUser.expiry!.isAfter(DateTime.now());
}
