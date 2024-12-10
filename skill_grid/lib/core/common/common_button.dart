import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.buttonText,
    required this.buttonColor, 
    required this.buttonTextColor,
    required this.onPressed
  });

  final String buttonText;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 295,
      height: 43,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: buttonColor,
        ),

        child: Text("Log In",
          style: GoogleFonts.caprasimo(
            color: buttonTextColor, fontSize: 18)),
      ),
    );
  }
}
