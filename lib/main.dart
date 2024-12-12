import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taga_cuyo/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}
