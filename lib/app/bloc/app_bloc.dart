import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/repository/repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required FirebaseAuthRepository firebaseAuth,
    required FirebaseDatabaseRepository firebaseDatabase,
  })  : _firebaseAuthRepository = firebaseAuth,
  _databaseRepository = firebaseDatabase,
  super(
    firebaseAuth.currentUser.isNotEmpty
    ? AppState(status: AppStatus.authenticated, user: firebaseAuth.currentUser)
    : const AppState(status: AppStatus.unauthenticated)
  ) {
    on<AppUserChanged>(_onAppUserChanged);
    on<AppLogoutRequested>(_onAppLogoutRequested);
    on<CheckUserExpiration>(_onCheckUserExpiration);

    _streamSubscription = _firebaseAuthRepository.user.listen((user) => add(AppUserChanged(user)));
  }
  final FirebaseAuthRepository _firebaseAuthRepository;
  final FirebaseDatabaseRepository _databaseRepository;
  late final StreamSubscription<User> _streamSubscription;

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    try {
      if (_isUserValid(event.user)) {
        if (_isUserNotExpired(await _getCurrentUser(event.user.uid!))) {
          emit(state.copyWith(status: AppStatus.authenticated, user: event.user));
        } else {
          emit(state.copyWith(status: AppStatus.unauthenticated));
          unawaited(_firebaseAuthRepository.logOut());
        }
      } else {
        emit(state.copyWith(status: AppStatus.unauthenticated));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onCheckUserExpiration(CheckUserExpiration event, Emitter<AppState> emit) async {
    try {
      final user = _firebaseAuthRepository.currentUser;
      if (_isUserValid(user)) {
        if (!_isUserNotExpired(await _getCurrentUser(user.uid!))) {
          unawaited(_firebaseAuthRepository.logOut());
          emit(state.copyWith(status: AppStatus.unauthenticated));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onAppLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_firebaseAuthRepository.logOut());
  }

  // check if user exists
  bool _isUserValid(User? user) => user != null && user.isNotEmpty;
  // get current user
  Future<Users> _getCurrentUser(String uid) async => _databaseRepository.getUsers(uid);
  // check user expiry
  bool _isUserNotExpired(Users currentUser) => currentUser.expiry!.isAfter(DateTime.now());

  @override
  Future<void> close() async {
    _streamSubscription.cancel();
    return super.close();
  }
}
