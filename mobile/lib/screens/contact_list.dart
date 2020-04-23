import 'package:flutter/material.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/transfer_form.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/components/loading.dart';
import 'package:bytebank/screens/transaction_form.dart';

const String _appBarTitle = 'Transfer';
final ContactDao _contactDao = ContactDao();

class ContactList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactListState();
  }
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: _contactDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              break;
            case ConnectionState.none:
              break;
            case ConnectionState.done:
              final List<Contact> _contacts = snapshot.data;
              return ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = _contacts[index];
                  return _ContactItem(
                    contact,
                    onClick: () => this._callNewTranscation(context, contact),
                  );
                },
              );
            case ConnectionState.waiting:
              return Loading();
          }
          return null;
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => this._callNewTransfer(context),
      ),
    );
  }

  _callNewTransfer(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ContactForm()));
  }

  _callNewTranscation(BuildContext context, Contact contact) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TransactionForm(contact)));
  }
}

class _ContactItem extends StatelessWidget {
  final Contact _contact;
  final Function onClick;

  _ContactItem(this._contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          _contact.name,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          _contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
