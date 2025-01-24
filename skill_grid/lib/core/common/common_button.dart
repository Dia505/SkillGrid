import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.buttonText,
    this.buttonColor,
    this.buttonTextColor,
    this.borderColor,
    required this.onPressed,
  });

  final String buttonText;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final VoidCallback onPressed;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 295,
      height: 43,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? Colors.transparent, // Default: No border
              width: 2, // Border width
            ),
            borderRadius: BorderRadius.circular(8), // Optional rounded corners
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor),
        ),
      ),
    );
  }
}
