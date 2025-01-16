import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/repository/repository.dart';
import 'package:fcb_calculator_v2_1/utils/utils.dart';

class App extends StatelessWidget {
  const App({super.key});
  static Route<AppStatus> route() => MaterialPageRoute(builder: (_) => const App());
  static final _authRepository = FirebaseAuthRepository();
  static final _databaseRepository = FirebaseDatabaseRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authRepository),
        RepositoryProvider(create: (context) => _databaseRepository)
      ],
      child: BlocProvider(
        create: (context) => AppBloc(
          firebaseAuth: _authRepository,
          firebaseDatabase: _databaseRepository
        )..add(CheckUserExpiration()),
        child: const AppView()
      )
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme(context: context).light,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGeneratePages,
      )
    );
  }
}