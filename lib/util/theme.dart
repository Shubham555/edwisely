import 'package:flutter/material.dart';

class EdwiselyTheme {
  static const Color PRIMARY_COLOR = Color(0xFF5154CD);
  static const Color NAV_BAR_COLOR = Color(0xFF2A2A2A);
  static const Color CARD_COLOR = Color(0xFFEEEEEE);
  static const Color CHIP_COLOR = Color(0xFF787878);
  //<editor-fold desc="This is the App theme for Edwisely">
  static final ThemeData themeDataEdwisely = ThemeData(
    brightness: Brightness.light,
    primaryColor: PRIMARY_COLOR,
    accentColor: Color(0xFF5E6BE7),
    backgroundColor: Color(0xFFE5E5E5),
    scaffoldBackgroundColor: Color(0xFFF9F9F9),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headline1: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 48.0,
      ),
      headline5: TextStyle(
        fontSize: 20.0,
      ),
      headline6: TextStyle(
        fontSize: 18.0,
      ),
    ),
  );
//</editor-fold>
}
