import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

class ToastMessage {
  static showWarning(BuildContext context, String msg) {
    return Toast.show(
      msg,
      context,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      duration: 2,
      gravity: Toast.TOP,
    );
  }

  static showInform(BuildContext context, String msg) {
    return Toast.show(
      msg,
      context,
      duration: 3,
      gravity: Toast.BOTTOM,
    );
  }

  static showAlert(BuildContext context, String msg) {
    return Toast.show(
      msg,
      context,
      duration: 4,
      gravity: Toast.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
