import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final IconData icon;
  final String value;
  final Function onChange;
  final String validate;

  const InputFormField({
    Key key,
    this.controller,
    this.type,
    this.label,
    this.icon,
    this.value,
    this.onChange,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      validator: (value) {
        if (value.isEmpty) return validate;

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
