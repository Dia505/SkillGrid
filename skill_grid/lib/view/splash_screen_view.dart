import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

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
                    
                Text(
                  "SkillGrid.", 
                  style:GoogleFonts.caprasimo(
                    color: const Color(0xFFE7E7FF),
                    fontSize: 40
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}