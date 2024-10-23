import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightThemeData = ThemeData(
    fontFamily: GoogleFonts.inter().fontFamily,
    brightness: Brightness.light,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue, // Text color
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          // backgroundColor: Colors.blue, // Background color
          // foregroundColor: Colors.white, // Text color
          // padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blue), // Border color
        // foregroundColor: Colors.blue, // Text color
        // padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue, // Set the button color
      textTheme: ButtonTextTheme.primary, // Set the button text theme
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.0,
        fontFamily: 'Inter',
      ),
      displayMedium: TextStyle(
        fontSize: 45.0,
        fontFamily: 'Inter',
      ),
      displaySmall: TextStyle(
        fontSize: 36.0,
        fontFamily: 'Inter',
      ),
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontFamily: 'Inter',
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        fontFamily: 'Inter',
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0,
        fontFamily: 'Inter',
      ),
      titleLarge: TextStyle(
        fontSize: 22.0,
        fontFamily: 'Inter',
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Inter',
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Inter',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Inter',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Inter',
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Inter',
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Inter',
      ),
      labelMedium: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Inter',
      ),
      labelSmall: TextStyle(
        fontSize: 11.0,
        fontFamily: 'Inter',
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(245, 246, 247, 1),
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(
            fill: BorderSide.strokeAlignCenter) // Set the selected item color
        ),

    cardTheme: CardTheme(
      color: Colors.white, // Set the card color
      elevation: 2, // Set the card elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Set the card border radius
      ),
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(239, 249, 255, 1),
    // Set the app bar color

    appBarTheme: const AppBarTheme(
      /*  backgroundColor:
          Color.fromRGBO(239, 249, 255, 1), */ // Set the background color
      // color: Color.fromRGBO(174, 206, 209, 1), // Set the app bar color
      iconTheme: IconThemeData(
        color: Colors.black, // Set the icon color
      ),
    ),
    //
    //
    // scaffoldBackgroundColor: Colors.grey[200],
  );

  static ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue, // Set the button color
      textTheme: ButtonTextTheme.primary, // Set the button text theme
    ),

    iconTheme: const IconThemeData(
      color: Colors.white, // Set the default color for icons
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.0,
        fontFamily: 'Inter',
      ),
      displayMedium: TextStyle(
        fontSize: 45.0,
        fontFamily: 'Inter',
      ),
      displaySmall: TextStyle(
        fontSize: 36.0,
        fontFamily: 'Inter',
      ),
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontFamily: 'Inter',
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        fontFamily: 'Inter',
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0,
        fontFamily: 'Inter',
      ),
      titleLarge: TextStyle(
        fontSize: 22.0,
        fontFamily: 'Inter',
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Inter',
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Inter',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Inter',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Inter',
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Inter',
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Inter',
      ),
      labelMedium: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Inter',
      ),
      labelSmall: TextStyle(
        fontSize: 11.0,
        fontFamily: 'Inter',
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[800], // Set the card color to a dark shade
      elevation: 2, // Set the card elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Set the card border radius
      ),
    ),
    appBarTheme: const AppBarTheme(
      /*  backgroundColor:
          Color.fromRGBO(239, 249, 255, 1), */ // Set the background color
      // color: Color.fromRGBO(174, 206, 209, 1), // Set the app bar color
      iconTheme: IconThemeData(
        color: Colors.white, // Set the icon color
      ),
    ),
    scaffoldBackgroundColor:
        Colors.black, // Set the background color to a dark shade
  );
}
