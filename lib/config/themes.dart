import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[200],
    primaryColor: Colors.blue,
    accentColor: Colors.teal,
    buttonColor: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backwardsCompatibility: true,
      backgroundColor: Colors.white,
      elevation: 2.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blue,
      elevation: 2.0,
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
      headline1: TextStyle(
        color: Colors.teal,
      ),
      // Auth forms headlines
      headline2: TextStyle(
        color: Colors.teal,
      ),
      // Used for section titles (e.g., in [HomeScreen]),
      headline5: TextStyle(),
      // Used for the primary text in app bars and dialogs (e.g., [AppBar.title]).
      headline6: TextStyle(),
      // Used for product description
      bodyText2: TextStyle(
        // fontSize: 12.0,
        color: Colors.grey[700],
      ),
      // Used for product/category names and auth forms subtitles
      subtitle1: TextStyle(),
      // Used for product prices
      subtitle2: TextStyle(
        color: Colors.teal,
        fontSize: 16.0,
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
    buttonColor: Colors.pink,
    brightness: Brightness.dark,
    backgroundColor: Color(0xff262623),
    appBarTheme: AppBarTheme(
      backwardsCompatibility: true,
      backgroundColor: Color(0xff262623),
      elevation: 2.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[850],
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.pink,
      elevation: 2.0,
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
      headline1: TextStyle(
        color: Colors.cyan,
      ),
      // Auth forms headlines
      headline2: TextStyle(
        color: Colors.cyan,
      ),
      // Used for section titles (e.g., in [HomeScreen]),
      headline5: TextStyle(),
      // Used for the primary text in app bars and dialogs (e.g., [AppBar.title]).
      headline6: TextStyle(),
      // Used for product description
      bodyText2: TextStyle(
        // fontSize: 12.0,
        color: Colors.grey[400],
      ),
      // Used for product/category names and auth forms subtitles
      subtitle1: TextStyle(),
      // Used for product prices
      subtitle2: TextStyle(
        color: Colors.cyan,
        fontSize: 16.0,
      ),
    ),
  );
}
