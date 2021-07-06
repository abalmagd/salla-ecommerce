import 'package:cirilla/shared/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    accentColor: Colors.grey,
    backgroundColor: Colors.white,
    textTheme: TextThemes.textThemes(context),
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(color: Colors.black),
      backgroundColor: Colors.white,
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
    scaffoldBackgroundColor: Color(0xff262623),
    primaryColor: Colors.blue,
    backgroundColor: Color(0xff262623),
    textTheme: TextThemes.textThemes(context),
    appBarTheme: AppBarTheme(
      backwardsCompatibility: true,
      backgroundColor: Color(0xff262623),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );
}
