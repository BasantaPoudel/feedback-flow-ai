import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    // Define the button theme
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue, // Set the button color
      textTheme: ButtonTextTheme.primary, // Set the button text theme
    ),

    // Define the card theme
    cardTheme: CardTheme(
      color: Colors.white, // Set the card color
      elevation: 2, // Set the card elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Set the card border radius
      ),
    ),

    // Define the background color for columns and rows
    scaffoldBackgroundColor: Colors.grey[200],

    // Add more theme properties as needed
  );
}
