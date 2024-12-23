import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.buttonText,
    this.buttonColor, 
    this.buttonTextColor,
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
          backgroundColor: buttonColor,
        ),

        child: Text(buttonText,
          style: TextStyle(color: buttonTextColor)),
      ),
    );
  }
}
