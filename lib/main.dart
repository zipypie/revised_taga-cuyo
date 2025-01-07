import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/app/app.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/firestore_user_progress_repository.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/firestore_user_repository.dart';
import 'package:taga_cuyo/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize repositories
  final userRepository = FirebaseUserRepository();
  final userProgressRepository =
      FirebaseUserProgressRepository(userRepository: userRepository);

  // Pass both repositories to MainApp
  runApp(MainApp(userRepository, userProgressRepository));
}
