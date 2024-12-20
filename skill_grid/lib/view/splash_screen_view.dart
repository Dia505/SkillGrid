import 'package:flutter/material.dart';
import 'package:skill_grid/view/onboard_screen_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next page after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardScreenView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: Container(
          width: double.infinity,
          color: const Color(0xFF322E86),

          child: Padding(
            padding: const EdgeInsets.only(bottom: 55),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/splash_screen_logo.png",
                  width: 151,
                  height: 154,),
                    
                const Text(
                  "SkillGrid.", 
                  style:TextStyle(
                    color: Color(0xFFE7E7FF),
                    fontSize: 40,
                    fontFamily: "Caprasimo"
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}