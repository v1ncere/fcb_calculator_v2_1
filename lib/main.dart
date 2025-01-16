import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:fcb_calculator_v2_1/repository/repository.dart';
import 'package:fcb_calculator_v2_1/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final firebaseAuthRepository = FirebaseAuthRepository();
  await firebaseAuthRepository.user.first;
  // Bloc.observer = const AppBlocObserver();
  
  runApp(const MaterialApp(home: Splash()));
}
