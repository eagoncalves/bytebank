import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/api/webclient.dart';

class TransactionService {
  Future<List<Transaction>> getTransactions() async {
    final Response response = await client.get('$baseUrl/transactions');
    return this._toTransactions(response);
  }

  Future<Transaction> saveTransaction(Transaction transaction, String password) async {

    final String transcationJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 3));

    final Response response = await client.post(
      '$baseUrl/transactions',
      headers: {
        'Content-type': 'application/json',
        'password': '$password',
      },
      body: transcationJson,
    );

    switch (response.statusCode) {
      case 200:
        return this._toTransaction(response);
        break;
      default:
        _throwHttpError(response.statusCode);
        break;
    }
  }

  _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  _toTransaction(Response response) => Transaction.fromJson(jsonDecode(response.body));

  void _throwHttpError(int statusCode) => throw HttpException(_getMessage(statusCode));

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    } else {
      return 'Unknwon error';
    }
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error on submitting transaction',
    401: 'Authentication failed',
    409: 'Already in transaction',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
