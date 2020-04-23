import 'package:flutter/material.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/api/services/transaction_service.dart';
import 'package:bytebank/components/loading.dart';
import 'package:bytebank/components/centered_message.dart';

final TransactionService _transactionService = TransactionService();

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        initialData: List(),
        future: _transactionService.getTransactions(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              break;
            case ConnectionState.none:
              break;
            case ConnectionState.done:
              final List<Transaction> _transactions = snapshot.data;
              if (snapshot.hasData) {
                if (_transactions.isNotEmpty) {
                  return ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      final Transaction transaction = _transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }

              return CenteredMessage(
                'No transactions found!',
                icon: Icons.warning,
              );
            // break;
            case ConnectionState.waiting:
              return Loading();
          }
          return CenteredMessage('Unkown error');
        },
      ),
    );
  }
}
