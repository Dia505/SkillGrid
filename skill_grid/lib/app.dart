import 'package:flutter/material.dart';
import 'package:skill_grid/view/login_screen_view.dart';
// import 'package:skill_grid/view/splash_screen_view.dart';
// import 'package:skill_grid/view/onboard_screen_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenView(),
    );
  }
}