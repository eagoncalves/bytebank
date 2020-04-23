import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;
  final bool visible;

  Loading({this.message = 'Loading', this.visible = false});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: this.visible,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(message),
            ),
          ],
        ),
      ),
    );
  }
}
