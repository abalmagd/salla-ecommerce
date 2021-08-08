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
    // cardColor: Colors.grey[800],
    brightness: Brightness.dark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[850],
      unselectedItemColor: Colors.grey[800],
      elevation: 2.0,
    ),
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
    // colorScheme: ColorScheme(
    //   brightness: Brightness.dark,
    //   onSurface: Colors.white,
    //   primary: Colors.pink,
    //   secondary: Colors.cyan,
    //   onError: Colors.red,
    //   primaryVariant: Colors.pinkAccent,
    //   error: Colors.red,
    //   onBackground: Colors.white,
    //   secondaryVariant: Colors.cyanAccent,
    //   background: Colors.grey[850],
    //   onPrimary: Colors.white,
    //   onSecondary: Colors.white,
    //   surface: Colors.grey[800],
    // ),
    textTheme: TextTheme(
      headline1: TextStyle(),
      headline2: TextStyle(),
      headline3: TextStyle(),
      headline4: TextStyle(),
      // Used for section titles (e.g., in [HomeScreen]),
      headline5: TextStyle(),
      // Used for the primary text in app bars and dialogs (e.g., [AppBar.title]).
      headline6: TextStyle(),
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
      // Used for product names
      subtitle1: TextStyle(),
      // Used for product prices
      subtitle2: TextStyle(
        color: Colors.cyan,
        fontSize: 16.0,
      ),
      button: TextStyle(),
    ),
  );
}
