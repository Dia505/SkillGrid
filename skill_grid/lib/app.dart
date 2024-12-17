import 'package:flutter/material.dart';
import 'package:skill_grid/view/client/client_registration_view.dart';
import 'package:skill_grid/view/freelancer/build_profile_screens/build_profile_lottie_view.dart';
// import 'package:skill_grid/view/client/client_registration_view.dart';
import 'package:skill_grid/view/freelancer/freelancer_registration_view.dart';
import 'package:skill_grid/view/onboard_screen_view.dart';
import 'package:skill_grid/view/splash_screen_view.dart';
// import 'package:skill_grid/view/client/client_registration_view.dart';
// import 'package:skill_grid/view/join_client_freelancer_view.dart';
// import 'package:skill_grid/view/login_screen_view.dart';
// import 'package:skill_grid/view/onboard_screen_view.dart';
// import 'package:skill_grid/view/onboard_screen_view.dart';
// import 'package:skill_grid/view/splash_screen_view.dart';
// import 'package:skill_grid/view/onboard_screen_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BuildProfileLottieView(),
    );
  }
}