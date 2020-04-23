import 'package:flutter/material.dart';
import 'package:bytebank/components/input.dart';
import 'package:bytebank/components/button.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/database/dao/contact_dao.dart';

class _ContactFormState extends State<ContactForm> {
  final String _appBarTitle = 'New Transfer';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final ContactDao _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Input(
              label: 'Full Name',
              hint: 'Your full name',
              controller: this._nameController,
            ),
            Input(
              label: 'Account number',
              hint: '000000',
              controller: this._accountController,
              textType: TextInputType.number,
            ),
            Button(
              title: 'Save',
              buttonWidth: double.maxFinite,
              onPress: () {
                this._addNewContact().then((id) => Navigator.pop(context));
              },
            )
          ],
        ),
      ),
    );
  }

  Future<int> _addNewContact() {
    final String name = _nameController.text;
    final int accountNumber = int.tryParse(_accountController.text);

    final Contact tranfer = Contact(0, name, accountNumber);

    this._clearFields();
    return _contactDao.save(tranfer);
  }

  void _clearFields() {
    _nameController.clear();
    _accountController.clear();
  }
}

class ContactForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactFormState();
  }
}
