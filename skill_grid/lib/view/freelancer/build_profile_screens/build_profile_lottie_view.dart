import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class BuildProfileLottieView extends StatelessWidget {
  const BuildProfileLottieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 208, 208, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Step Into The Spotlight",
            style: GoogleFonts.caprasimo(
              fontSize: 24,
              color: const Color(0xFF322E86)
            )),

            const SizedBox(height: 15),

            SizedBox(
              width: 300,
              child: Text("Let’s set up your freelance profile and connect you with clients who need your skills",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: const Color(0xFF322E86)
              )),
            ),

            Lottie.asset(
              "assets/lottie_files/cC12EMk7xy.json",
              width: 500,
              height: 300,
              repeat: true, // Animation repeats
              animate: true, // Starts animation automatically
            ),

            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF322E86)), 
              strokeWidth: 2.0,
            )
          ],
        )
      ),
    );
  }
}