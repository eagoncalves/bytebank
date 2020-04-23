import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String _titleDialog = 'Authenticate';
const String _cancelButtonTitle = 'Cancel';
const String _confirmButtonTitle = 'Confirm';

class TransactionActionDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionActionDialog({@required this.onConfirm});

  @override
  _TransactionActionDialogState createState() =>
      _TransactionActionDialogState();
}

class _TransactionActionDialogState extends State<TransactionActionDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isOS) {
      return CupertinoAlertDialog(
        title: Text(_titleDialog),
        content: _TextFieldAuth(
          controller: _passwordController,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(_cancelButtonTitle),
            onPressed: () => _onCloseDialog(context),
          ),
          FlatButton(
            child: Text(_confirmButtonTitle),
            onPressed: () {
              widget.onConfirm(_passwordController.text);
              _onCloseDialog(context);
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(_titleDialog),
        content: _TextFieldAuth(
          controller: _passwordController,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(_cancelButtonTitle),
            onPressed: () => _onCloseDialog(context),
          ),
          FlatButton(
            child: Text(_confirmButtonTitle),
            onPressed: () {
              widget.onConfirm(_passwordController.text);
              _onCloseDialog(context);
            },
          ),
        ],
      );
    }
  }
}

class _TextFieldAuth extends StatelessWidget {
  final TextEditingController controller;

  _TextFieldAuth({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.transparent,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 52,
          letterSpacing: 10,
        ),
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

_onCloseDialog(BuildContext context) {
  Navigator.pop(context);
}
