import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/bot_nav.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const BottomNavBar(),
    );
  }
}
