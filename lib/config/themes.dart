import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.black,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(color: Colors.black),
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );
}

// TODO: Fix this later when theme switch is added
ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[850],
    primaryColor: Colors.pink,
    accentColor: Colors.cyan,
    cardColor: Colors.grey[800],
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[850], unselectedItemColor: Colors.grey[800], elevation: 2.0),
    backgroundColor: Color(0xff262623),
    appBarTheme: AppBarTheme(
      backwardsCompatibility: true,
      backgroundColor: Color(0xff262623),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      onSurface: Colors.white,
      primary: Colors.pink,
      secondary: Colors.cyan,
      onError: Colors.red,
      primaryVariant: Colors.pinkAccent,
      error: Colors.red,
      onBackground: Colors.white,
      secondaryVariant: Colors.cyanAccent,
      background: Colors.grey[850],
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      surface: Colors.grey[800],
    ),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
      subtitle2: TextStyle(color: Theme.of(context).primaryColor),
      button: TextStyle(),
      caption: TextStyle(),
      headline1: TextStyle(),
      headline2: TextStyle(),
      headline3: TextStyle(),
      headline4: TextStyle(),
      overline: TextStyle(),
      subtitle1: TextStyle(),
    ),
  );
}
