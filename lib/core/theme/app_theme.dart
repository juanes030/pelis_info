import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: Color(0xFF2862F5),
    brightness: Brightness.light,
  );

  ThemeData getDarkTheme() => ThemeData(
    colorSchemeSeed: Color(0xFF2862F5),
    brightness: Brightness.dark,
  );
}