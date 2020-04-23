import 'package:flutter/material.dart';
import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/components/action_button.dart';
import 'package:bytebank/screens/transaction_list.dart';

const String _appBarTitle = 'Dashboard';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                ActionButton(
                  title: 'Transfer',
                  icon: Icons.monetization_on,
                  onPress: () => this._openContactList(context),
                ),
                ActionButton(
                  title: 'Transaction feed',
                  icon: Icons.description,
                  onPress: () => this._openTransactionFeed(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _openContactList(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ContactList()));
  }

  _openTransactionFeed(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TransactionsList()));
  }
}
