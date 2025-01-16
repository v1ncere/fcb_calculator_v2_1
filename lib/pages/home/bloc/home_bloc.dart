import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fcb_calculator_v2_1/repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required FirebaseDatabaseRepository firebaseDatabaseRepository,
  }) : _databaseRepository = firebaseDatabaseRepository,
   super(const HomeState()) {
    on<UserLoaded>(_onUserLoaded);
  }
  final FirebaseDatabaseRepository _databaseRepository;

  void _onUserLoaded(UserLoaded event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final users = await _databaseRepository.getUsers(FirebaseAuth.instance.currentUser!.uid);
      emit(state.copyWith(status: Status.success, user: users));
    } catch (err) {
      emit(state.copyWith(status: Status.failure, message: err.toString()));
    }
  }
}
