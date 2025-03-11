import 'package:flutter/material.dart';
import 'colors.dart'; // Import the custom colors

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: primarySwatch, // Use custom primarySwatch
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[100],
    splashFactory: InkRipple.splashFactory,
    highlightColor: Colors.transparent,
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: primarySwatch,
    brightness: Brightness.dark,
  );
}
