import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/view/login_screen_view.dart';

class OnboardScreenView extends StatelessWidget {
  const OnboardScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFF322E86),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [
            Container(
              width: 190,
              padding: const EdgeInsets.only(top: 100),
        
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                children: [
                  Image.asset(
                    "assets/images/splash_screen_logo.png",
                    width: 48,
                    height: 50,),
                      
                  Text(
                    "SkillGrid.", 
                    style:GoogleFonts.caprasimo(
                      color: const Color(0xFFE7E7FF),
                      fontSize: 24
                    ))
                ],
              ),
            ),
        
            Image.asset(
              "assets/images/splash_screen2_img.png",
              width: 255,
              height: 266),
        
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  Text("Where Skills Find Purpose",
                  style:GoogleFonts.caprasimo(
                    color: const Color(0xFFE7E7FF),
                    fontSize: 20
                  )),
              
                  Container(
                    width: 256,
                    padding: const EdgeInsets.only(top: 10),
              
                    child: Text("Connecting clients and freelancers for impactful projects",
                      textAlign: TextAlign.center,
                      style:GoogleFonts.inter(
                        color: const Color(0xFFE7E7FF),
                        fontSize: 14,
                      )
                    ),
                  ),
                ],
              ),
            ),
        
            CommonButton(
              buttonText: "Log In", 
              buttonColor: Color(0xFFE7E7FF), 
              buttonTextColor: Color(0xFF322E86),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreenView()));
              },
            ),
                        
            Container(
              width: 188,
              padding: const EdgeInsets.only(bottom: 70),
                        
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                children: [
                  Text("New to SkillGrid?",
                  style:GoogleFonts.inter(
                    color: const Color(0xFFE7E7FF),
                    fontSize: 14,
                  )),
              
                  Text("Sign up",
                  style:GoogleFonts.caprasimo(
                    color: const Color(0xFFE7E7FF),
                    fontSize: 14,
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}