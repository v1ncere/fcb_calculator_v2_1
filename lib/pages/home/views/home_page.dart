import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/pages/home/home.dart';
import 'package:fcb_calculator_v2_1/repository/repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage(child: HomePage());
  static final _authRepository = FirebaseAuthRepository();
  static final _databaseRepository = FirebaseDatabaseRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository),
        RepositoryProvider(create: (context) => _databaseRepository)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(firebaseAuth: _authRepository, firebaseDatabase: _databaseRepository)
            ..add(CheckUserExpiration())
          ),
          BlocProvider(
            create: (context) => HomeBloc(firebaseDatabaseRepository: _databaseRepository)
            ..add(UserLoaded())
          )
        ],
        child: const HomeView(),
      )
    );
  }
}