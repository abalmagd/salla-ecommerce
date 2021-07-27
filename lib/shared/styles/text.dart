import 'package:flutter/material.dart';

class TextThemes {
  static TextStyle itemPrice(context) => TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16.0,
      );

  static TextStyle itemOldPrice(BuildContext context) => TextStyle(
        color: Colors.grey[600],
        fontSize: 14.0,
        decoration: TextDecoration.lineThrough,
      );

  static TextStyle normalText(BuildContext context) => TextStyle(
        fontSize: 18.0,
      );

  static TextStyle subText(BuildContext context) => TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      );

  static TextStyle sectionHeader(BuildContext context) => TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
      );

  static TextStyle appBarTitle(BuildContext context) => TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      );

  static TextStyle formTitle(BuildContext context) => TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 64.0,
      );
}
