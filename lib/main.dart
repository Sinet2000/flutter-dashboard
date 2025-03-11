import 'package:flutter/material.dart';
import 'package:my_first_app/config/theme.dart';
import 'package:my_first_app/presentation/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: AppTheme.lightTheme, // Apply light theme
      darkTheme: AppTheme.darkTheme,
    );
  }
}
