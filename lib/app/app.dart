import 'package:flutter/material.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/app/themes/themes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.main,
    );
  }
}
