import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType textType;
  final bool firstFieldFocus;
  final double horizontalPadding;
  final double verticalPadding;

  Input({
    this.label,
    this.hint,
    this.icon,
    this.controller,
    this.firstFieldFocus,
    this.textType,
    this.horizontalPadding = 24,
    this.verticalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: this.horizontalPadding,
        vertical: this.verticalPadding,
      ),
      child: TextField(
        controller: this.controller,
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          icon: this.icon != null ? Icon(this.icon) : null,
          labelText: this.label,
          hintText: this.hint,
        ),
        keyboardType: this.textType,
      ),
    );
  }
}
