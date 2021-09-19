import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final IconData icon;
  final String value;
  final Function onChange;
  final String validate;
  final bool obscureText;

  const InputFormField({
    Key key,
    this.controller,
    this.type,
    this.label,
    this.icon,
    this.value,
    this.onChange,
    this.validate,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      initialValue: value,
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      obscureText: obscureText,
      validator: (value) {
        if (value.isEmpty) return validate;

        return null;
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        // focusColor: Theme.of(context).primaryColor,
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
