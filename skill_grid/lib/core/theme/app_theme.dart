import 'package:flutter/material.dart';
import 'package:skill_grid/app/constants/theme_constant.dart';

ThemeData getApplicationTheme({required bool isDarkMode}) {
  return ThemeData(
      colorScheme: isDarkMode
          ? const ColorScheme.dark(primary: ThemeConstant.darkPrimaryColor)
          : const ColorScheme.light(primary: ThemeConstant.lightPrimaryColor),
      scaffoldBackgroundColor: isDarkMode
          ? ThemeConstant.darkPrimaryColor
          : ThemeConstant.lightPrimaryColor,
      fontFamily: "Inter Regular",
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18, fontFamily: "Caprasimo"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        foregroundColor: isDarkMode
            ? ThemeConstant.darkPrimaryColor
            : ThemeConstant.lightPrimaryColor,
        backgroundColor: isDarkMode
            ? ThemeConstant.lightPrimaryColor
            : ThemeConstant.darkPrimaryColor,
      )),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                  color: isDarkMode
                      ? ThemeConstant.lightPrimaryColor
                      : ThemeConstant.darkPrimaryColor,
                  width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                  color: isDarkMode
                      ? ThemeConstant.lightPrimaryColor
                      : ThemeConstant.darkPrimaryColor,
                  width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.red, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.red, width: 2))));
}
