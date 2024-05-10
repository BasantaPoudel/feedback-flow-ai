import 'package:flutter/material.dart';
import 'package:material_color_gen/material_color_gen.dart';

class AppTheme {
  static ThemeData currentTheme = ThemeData(
    primarySwatch: const Color(0x00049ee0).toMaterialColor(),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0x00108EC5).toMaterialColor(),
      brightness: Brightness.light,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0x00049ee0).toMaterialColor(),
    ),
  );

  static ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue, // Set the button color
      textTheme: ButtonTextTheme.primary, // Set the button text theme
    ),
    cardTheme: CardTheme(
      color: Colors.white, // Set the card color
      elevation: 2, // Set the card elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Set the card border radius
      ),
    ),
    scaffoldBackgroundColor: Colors.grey[200],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue, // Set the button color
      textTheme: ButtonTextTheme.primary, // Set the button text theme
    ),

    iconTheme: const IconThemeData(
      color: Colors.white, // Set the default color for icons
    ),

    cardTheme: CardTheme(
      color: Colors.grey[800], // Set the card color to a dark shade
      elevation: 2, // Set the card elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Set the card border radius
      ),
    ),

    scaffoldBackgroundColor:
        Colors.grey[900], // Set the background color to a dark shade
  );
}
