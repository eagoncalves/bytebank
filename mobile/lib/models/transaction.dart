import 'package:bytebank/models/contact.dart';

class Transaction {
  final String id;
  final double value;
  final Contact contact;

  Transaction(this.id, this.value, this.contact);

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'],
        contact = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'value': this.value,
        'contact': this.contact.toJson(),
      };

  @override
  String toString() {
    return 'Transaction{value: $this. contact: $this.contact, id: $this.øid}';
  }
}
