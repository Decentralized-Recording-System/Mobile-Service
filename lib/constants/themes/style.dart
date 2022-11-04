import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.grey,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.blue,
      primaryColor: Colors.blue,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.white,
      secondaryHeaderColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.blue, fontSize: 22.0),
        headline2: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.greenAccent),
        subtitle1: TextStyle(color: Colors.pinkAccent),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
      ));

  static ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      scaffoldBackgroundColor: Color.fromARGB(255, 48, 49, 49),
      backgroundColor: Color.fromARGB(255, 102, 197, 173),
      primaryColor: const Color.fromARGB(255, 102, 197, 173),
      primaryColorLight: Color.fromARGB(255, 48, 49, 49),
      primaryColorDark: Colors.white,
      secondaryHeaderColor: const Color.fromARGB(255, 37, 37, 37),
      colorScheme: const ColorScheme.light(),
      textTheme: const TextTheme(
        overline: TextStyle(color: Colors.white),
        headline1: TextStyle(color: Colors.white, fontSize: 22.0),
        headline2: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.greenAccent),
        subtitle1: TextStyle(color: Colors.pinkAccent),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 102, 197, 173),
      ));
}
