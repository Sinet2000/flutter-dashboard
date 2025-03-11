import 'package:flutter/material.dart';
import 'colors.dart'; // Import the custom colors

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xFF4CAF50),
    primarySwatch: primarySwatch, // Use custom primarySwatch
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFf8f9fa),
    splashFactory: InkRipple.splashFactory,
    highlightColor: Colors.transparent,
    // textTheme: TextTheme(
    //   headline6: TextStyle(
    //     fontSize: 24.0,
    //     fontWeight: FontWeight.bold,
    //     color: Color(0xFF333333),
    //   ),
    //   subtitle1: TextStyle(fontSize: 16.0, color: Color(0xFF666666)),
    //   bodyText2: TextStyle(fontSize: 16.0, color: Color(0xFF333333)),
    // ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFe9ecef),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(width: 2.0, color: primarySwatch.shade500),
      ),
      labelStyle: TextStyle(color: Color(0xFF333333)),
      suffixIconColor: Colors.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // primaryColor: Color(0xFF4CAF50),
        // onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0),
        textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ),
    fontFamily: 'Roboto',
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: primarySwatch,
    brightness: Brightness.dark,
  );
}
