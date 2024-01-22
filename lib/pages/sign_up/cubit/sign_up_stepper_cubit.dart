import 'package:bloc/bloc.dart';

class SignUpStepperCubit extends Cubit<int> {
  SignUpStepperCubit({required this.stepLength}) : super(0);
  final int stepLength;

  void stepTapped(int index) {
    emit(index);
  }

  void stepContinued() {
    if (state < stepLength - 1) {
      emit(state + 1);
    } else {
      emit(state);
    }
  }

  void stepCancelled() {
    if (state > 0) {
      emit(state - 1);
    } else {
      emit(state);
    }
  }
}
