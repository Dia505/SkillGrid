import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFE7E7FF),
      fontFamily: "Inter Regular",

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18, fontFamily: "Caprasimo"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        foregroundColor: const Color(0xFFE7E7FF),
        backgroundColor: const Color(0xFF322E86),
      )),

      inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),

          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Color(0xFF322E86), width: 1)),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Color(0xFF322E86), width: 2)),

          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.red, width: 1)),
              
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.red, width: 2))));
}
