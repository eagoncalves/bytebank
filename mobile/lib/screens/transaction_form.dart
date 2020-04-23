import 'dart:async';
import 'dart:io';

import 'package:bytebank/components/loading.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_action_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/components/button.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/components/input.dart';
import 'package:bytebank/api/services/transaction_service.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionService _transactionService = TransactionService();
  final String transactionUuid = Uuid().v4();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Loading(message: 'Sending ...', visible: _sending,),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Input(
                label: 'Value',
                controller: _valueController,
                horizontalPadding: 0,
                verticalPadding: 0,
                textType: TextInputType.number,
              ),
              Button(
                title: 'Transfer',
                buttonWidth: double.maxFinite,
                horizontalPadding: 0,
                onPress: () {
                  final Transaction transaction = Transaction(
                    transactionUuid,
                    double.tryParse(_valueController.text),
                    widget.contact,
                  );
                  this._handleTransfer(
                    context,
                    transaction,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleTransfer(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (contextDialog) => TransactionActionDialog(
        onConfirm: (String password) {
          _confirmTransfer(context, transaction, password);
        },
      ),
    );
  }

  _confirmTransfer(
    BuildContext context,
    Transaction transaction,
    String password,
  ) async {
    setState(() {
      _sending = true;
    });

    Transaction newtransaction = await _sendTransfer(
      context,
      transaction,
      password,
    );
    _showSuccessTransfer(newtransaction);
  }

  Future _showSuccessTransfer(Transaction newtransaction) async {
    if (newtransaction != null) {
      await showDialog(
        context: context,
        builder: (contextDialog) => SuccessDialog('Success'),
      );
      Navigator.of(context).pop();
    }
  }

  Future<Transaction> _sendTransfer(
    BuildContext context,
    Transaction transaction,
    String password,
  ) async {
    Transaction newTransaction = await _transactionService.saveTransaction(
      transaction,
      password,
    ).catchError((err) {
      _showFailureMessage(context, message: 'Timeout');
    }, test: (err) => err is TimeoutException).catchError((err) {
      _showFailureMessage(context, message: 'Connection refured');
    }, test: (err) => err is SocketException).catchError((err) {
      _showFailureMessage(context, message: err.message);
    }, test: (err) => err is HttpException).catchError((err) {
      _showFailureMessage(context);
    }, test: (err) => err is Exception)
    .whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
    return newTransaction;
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknown error'}) {
    showDialog(
      context: context,
      builder: (contextDialog) => FailureDialog(message),
    );
  }
}
