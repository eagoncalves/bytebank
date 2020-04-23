import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPress;
  final double buttonWidth;
  final double horizontalPadding;
  final double verticalPadding;

  Button({
    this.title,
    this.onPress,
    this.buttonWidth,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: SizedBox(
        width: this.buttonWidth,
        child: RaisedButton(
          onPressed: () => this.onPress(),
          child: Text(this.title),
        ),
      ),
    );
  }
}
