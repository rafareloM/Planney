import 'package:flutter/material.dart';

abstract class AppStyle {
  static MaterialColor primaryColor = Colors.orange;
  static MaterialColor secondaryColor = Colors.lightBlue;
  static Color backgroundColorDark = const Color(0xFF121212);
  static Color errorDark = const Color(0xFFCF6679);
  static Color errorLight = const Color(0xFFB00020);
  static Color fullBlack = Colors.black;
  static Color fullWhite = Colors.white;
  /*---------------------------------------------------*/
  static ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor[200]!,
      primaryContainer: primaryColor[700],
      onPrimary: fullBlack,
      secondary: secondaryColor[300]!,
      secondaryContainer: secondaryColor[200],
      onSecondary: fullBlack,
      error: errorDark,
      onError: fullBlack,
      background: backgroundColorDark,
      onBackground: fullWhite,
      surface: backgroundColorDark,
      onSurface: fullWhite);
  /*---------------------------------------------------*/
  static ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor[500]!,
      primaryContainer: primaryColor[700],
      onPrimary: fullWhite,
      secondary: secondaryColor[200]!,
      secondaryContainer: secondaryColor[900],
      onSecondary: fullBlack,
      error: errorLight,
      onError: fullWhite,
      background: fullWhite,
      onBackground: fullBlack,
      surface: fullWhite,
      onSurface: fullBlack);
  /*---------------------------------------------------*/
  /*---------------------------------------------------*/
  static ThemeData appThemeDark = ThemeData(
    applyElevationOverlayColor: true,
    colorScheme: darkColorScheme,
    iconTheme: IconThemeData(
      color: primaryColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
    ),
  );
  /*---------------------------------------------------*/
  static ThemeData appThemeLight = ThemeData(
    colorScheme: lightColorScheme,
    appBarTheme: AppBarTheme(
      color: lightColorScheme.secondaryContainer,
    ),
  );
}
