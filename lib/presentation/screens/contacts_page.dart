import 'package:flutter/material.dart';
import 'package:my_first_app/core/models/contact_model.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key, required this.contacts});

  final List<Contact> contacts;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Contacts Page', style: TextStyle(fontSize: 24)));
  }
}
