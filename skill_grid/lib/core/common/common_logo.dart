import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonLogo extends StatelessWidget {
  const CommonLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      padding: const EdgeInsets.only(top: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/splash_screen_logo.png",
            width: 48,
            height: 50,
          ),
          Text("SkillGrid.",
              style: GoogleFonts.caprasimo(
                  color: const Color(0xFFE7E7FF), fontSize: 24))
        ],
      ),
    );
  }
}
