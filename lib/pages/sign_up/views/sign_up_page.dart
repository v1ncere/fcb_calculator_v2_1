import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/pages/sign_up/sign_up.dart';
import 'package:fcb_calculator_v2_1/repository/repository.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: SignUpPage());

  static final FirebaseAuthRepository _authRepository = FirebaseAuthRepository();
  static final FirebaseDatabaseRepository _databaseRepository = FirebaseDatabaseRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository),
        RepositoryProvider(create: (context) => _databaseRepository)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignUpBloc(
            authRepository: _authRepository,
            databaseRepository: _databaseRepository
          )),
          BlocProvider(create: (context) => SignUpStepperCubit(stepLength: 2)),
        ],
        child: const SignUpStepperView()
      )
    );
  }
}