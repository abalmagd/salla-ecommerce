import 'package:flutter/material.dart';

class TextThemes {
  static TextTheme textThemes(BuildContext context) {
    return TextTheme(
      // Headlines
      headline5: TextStyle(
        fontSize: 24,
        fontFamily: 'assets/fonts/Roboto-Regular.ttf',
        fontWeight: FontWeight.w600,
      ),

      // Normal text
      bodyText1: TextStyle(
        letterSpacing: 0.25,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),

      // Normal bigger text (ie: price)
      bodyText2: TextStyle(
        letterSpacing: 0.5,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),


      // Home screen grid item old price
      headline6: TextStyle(
        fontSize: 14,
        letterSpacing: 0.25,
        color: Colors.grey,
        decoration: TextDecoration.lineThrough,
      ),


      // Subtexts (ie: Auth register/login prompt, Home categories text)
      subtitle1: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    );
  }
}
