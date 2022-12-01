import 'package:flutter/material.dart';

abstract class AppStyle {
  static Color primaryColor = const Color.fromARGB(255, 24, 107, 203);
  static Color secondaryColor = const Color.fromARGB(255, 247, 247, 247);
  static Color backgroundColorDark = const Color.fromARGB(255, 0, 0, 0);
  static Color backgroundColorlight = const Color(0xFFEDF0F5);
  static Color inputlight = const Color(0xFFD3E4ED);
  static Color iconsLight = const Color.fromARGB(255, 6, 16, 43);
  static Color errorDark = const Color(0xFFCF6679);
  static Color errorLight = const Color(0xFFB00020);
  static Color fullBlack = const Color.fromARGB(255, 7, 7, 7);;
  static Color fullWhite = Colors.white;
  static Color floatingActionButtomLight = const Color(0xFF32B8DA);
  static Color userNameColor = const Color(0xFFB8E5FF);
  static Color initialchartcolor = const Color(0xFFA8BCC7);
  static Color chartcolor1 = const Color(0xFF76B4D8);
  static Color chartcolor2 = const Color(0xFF9D7AD4);
  static Color chartcolor3 = const Color(0xFF8BDFD0);
  static Color chartcolor4 = const Color(0xFF2F498C);
  static Color graytextbox = const Color.fromARGB(255, 165, 165, 165);

  
  /*---------------------------------------------------*/
  static ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      primaryContainer: primaryColor,
      onPrimary: fullWhite,
      secondary: secondaryColor,
      secondaryContainer: secondaryColor,
      onSecondary: fullBlack,
      tertiary: userNameColor,
      error: errorDark,
      onError: fullBlack,
      background: backgroundColorDark,
      onBackground: fullWhite,
      surface: backgroundColorDark,
      onSurface: fullWhite);

  /*---------------------------------------------------*/
  static ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      primaryContainer: primaryColor,
      onPrimary: fullWhite,
      secondary: secondaryColor,
      secondaryContainer: secondaryColor,
      onSecondary: fullBlack,
      tertiary: userNameColor,
      error: errorLight,
      onError: fullWhite,
      background: fullWhite,
      onBackground: fullBlack,
      surface: fullWhite,
      onSurface: fullBlack);
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
    brightness: Brightness.dark,
  );
  /*---------------------------------------------------*/
  static ThemeData appThemeLight = ThemeData(
    colorScheme: lightColorScheme,
    appBarTheme: AppBarTheme(
      color: lightColorScheme.secondaryContainer,
    ),
    brightness: Brightness.light,
  );
}
