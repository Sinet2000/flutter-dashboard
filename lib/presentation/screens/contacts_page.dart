import 'package:flutter/material.dart';
import 'package:my_first_app/core/models/contact_model.dart';
import 'package:my_first_app/presentation/widgets/contacts/contact_details.dart';
import 'package:my_first_app/presentation/widgets/contacts/update_contact_form.dart';

class ContactsPage extends StatelessWidget {
  final List<Contact> contacts;
  final void Function(Contact newContact) onAddContact;

  const ContactsPage({
    super.key,
    required this.contacts,
    required this.onAddContact,
  });

  void _showContactForm(BuildContext context, {Contact? contact}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // For full-screen height if needed
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: UpdateContactForm(contact: contact),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text('${contact.firstName} ${contact.lastName}'),
            subtitle: Text(contact.email),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetails(contact: contact),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onPressed: () => _showContactForm(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
