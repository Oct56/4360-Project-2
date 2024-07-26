import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  // Colors
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 233, 234, 235),
    onPrimary: Colors.black54,
    secondary: const Color.fromARGB(255, 92, 197, 250),
    onSecondary: Colors.black54,
    error: Colors.redAccent,
    onError: Colors.black54,
    surface: Colors.white,
    onSurface: Colors.black54,
    outline: Colors.black54,
    shadow: Color.fromARGB(255, 224, 227, 239),
  ),
  
  // Font family
  fontFamily: 'Roboto',
  
  // Text sizes according to Google Material Design guidelines
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 96.0, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    displayMedium: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    displaySmall: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400, letterSpacing: 0.0),
    headlineLarge: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500, letterSpacing: 0.0),
    headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    titleMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    titleSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, letterSpacing: 0.4),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, letterSpacing: 0.4),
    labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
  ),
  
  // Button themes
  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromARGB(255, 92, 197, 250),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),

    // Button themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 92, 197, 250)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  ),
  
  // Card theme
  cardTheme: CardTheme(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  
  // Input decoration theme for text fields
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: const Color.fromARGB(255, 92, 197, 250), width: 2.0),
    ),
    labelStyle: TextStyle(color: const Color.fromARGB(255, 92, 197, 250)),
  ),
  
  // Bottom navigation bar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Color.fromARGB(255, 92, 197, 250), 
    unselectedItemColor: Colors.grey, 
  ),
);
