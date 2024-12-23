import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skill_grid/view/freelancer/build_profile_screens/build_profile_progress_view.dart';

class BuildProfileLottieView extends StatefulWidget {
  const BuildProfileLottieView({super.key});

  @override
  State<BuildProfileLottieView> createState() => _BuildProfileLottieViewState();
}

class _BuildProfileLottieViewState extends State<BuildProfileLottieView> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next page after 2 seconds
    Future.delayed(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BuildProfileProgressView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 208, 208, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Step Into The Spotlight",
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF322E86),
              fontFamily: "Caprasimo"
            )),

            const SizedBox(height: 15),

            const SizedBox(
              width: 300,
              child: Text("Let’s set up your freelance profile and connect you with clients who need your skills",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF322E86) 
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