import 'package:flutter/material.dart';
import 'package:material_color_gen/material_color_gen.dart';

class AppTheme {
  static ThemeData currentTheme = ThemeData(
    primarySwatch: const Color(0x00049ee0).toMaterialColor(),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0x00108EC5).toMaterialColor(),
      brightness: Brightness.light,
    ),
  );

  static ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue, // Set the button color
      textTheme: ButtonTextTheme.primary, // Set the button text theme
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 36.0,
        fontStyle: FontStyle.italic,
      ),
      displaySmall: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Hind',
      ),
      bodyLarge: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Hind',
      ),
      bodyMedium: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Hind',
      ),
      bodySmall: TextStyle(
        fontSize: 10.0,
        fontFamily: 'Hind',
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(174, 206, 209, 1),
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
    scaffoldBackgroundColor:
        const Color.fromRGBO(174, 206, 209, 1), // Set the background color
    // Set the app bar color

    appBarTheme: const AppBarTheme(
      backgroundColor:
          Color.fromRGBO(174, 206, 209, 1), // Set the app bar color
      // color: Color.fromRGBO(174, 206, 209, 1), // Set the app bar color
      iconTheme: IconThemeData(
        color: Colors.white, // Set the icon color
      ),
    ),
    //
    //
    // scaffoldBackgroundColor: Colors.grey[200],
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
        Colors.black, // Set the background color to a dark shade
  );
}
