import 'package:fcb_calculator_v2_1/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:fcb_calculator_v2_1/app/app.dart';
import 'package:fcb_calculator_v2_1/repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final firebaseAuthRepository = FirebaseAuthRepository();
  await firebaseAuthRepository.user.first;
  await Hive.initFlutter();
  Bloc.observer = const AppBlocObserver();
  runApp(const MaterialApp(home: Splash()));
}
