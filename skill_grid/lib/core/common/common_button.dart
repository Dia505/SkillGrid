import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 295,
        height: 43,
                        
        child: ElevatedButton(
          onPressed: (){}, 
                        
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9)
            )
          ),
                        
          child: Text("Log In",
            style:GoogleFonts.caprasimo(
              color: const Color(0xFF322E86),
              fontSize: 18
          )),
        ),
      ),
    );
  }
}