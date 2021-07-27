import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double width;
  final Color textColor;
  final Color buttonColor;
  final bool fullWidth;
  final bool upperCase;

  const DefaultButton({
    Key key,
    this.onPressed,
    this.text,
    this.width,
    this.buttonColor,
    this.textColor = Colors.white,
    this.fullWidth = true,
    this.upperCase = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : width ?? null,
      child: MaterialButton(
        height: 42.0,
        onPressed: onPressed,
        color: buttonColor ?? Theme.of(context).primaryColor,
        child: Text(
          upperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
