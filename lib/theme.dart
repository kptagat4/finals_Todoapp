import 'package:flutter/material.dart';

const Color asianBlue = Color(0xFF0056b3);
const Color asianGold = Color(0xFFFFD700);

final ThemeData themeData = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: asianBlue,
    onPrimary: Colors.white,
    secondary: asianGold,
    onSecondary: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: asianBlue,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: asianGold,
      foregroundColor: Colors.black,
    ),
  ),
);
