import 'package:flutter/material.dart';
import 'package:my_first_app/config/theme.dart';
import 'package:my_first_app/core/models/contact_model.dart';
import 'package:my_first_app/presentation/screens/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Sample contacts
  final List<Contact> contacts = [
    Contact(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phone: '123-456-7890',
      address: Address(
        addressLine: '123 Main St',
        postalCode: '12345',
        additionalDetails: 'Apt 1A',
        country: 'USA',
        city: 'New York',
      ),
    ),
    Contact(
      firstName: 'Jane',
      lastName: 'Smith',
      email: 'jane.smith@example.com',
      phone: '987-654-3210',
      address: Address(
        addressLine: '456 Market St',
        postalCode: '67890',
        additionalDetails: '',
        country: 'USA',
        city: 'San Francisco',
      ),
    ),
  ];

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Contact Management',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  //       scaffoldBackgroundColor: Colors.grey[100],
  //     ),
  //     home: HomeScreen(contacts: contacts),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: AppTheme.lightTheme, // Apply light theme
      darkTheme: AppTheme.darkTheme,
    );
  }
}

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
          child: ContactForm(contact: contact),
        ),
  );
}

class ContactForm extends StatefulWidget {
  final Contact? contact;
  const ContactForm({super.key, this.contact});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressLineController;
  late TextEditingController _cityController;
  late TextEditingController _postalCodeController;
  late TextEditingController _countryController;
  late TextEditingController _additionalController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers; if editing, pre-fill with existing values
    _firstNameController = TextEditingController(
      text: widget.contact?.firstName ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.contact?.lastName ?? '',
    );
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
    _addressLineController = TextEditingController(
      text: widget.contact?.address.addressLine ?? '',
    );
    _cityController = TextEditingController(
      text: widget.contact?.address.city ?? '',
    );
    _postalCodeController = TextEditingController(
      text: widget.contact?.address.postalCode ?? '',
    );
    _countryController = TextEditingController(
      text: widget.contact?.address.country ?? '',
    );
    _additionalController = TextEditingController(
      text: widget.contact?.address.additionalDetails ?? '',
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressLineController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    _additionalController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Here, you can either create a new Contact or update an existing one.
      // For now, we'll just print the values.
      print('First Name: ${_firstNameController.text}');
      print('Last Name: ${_lastNameController.text}');
      // ... more prints or logic to store the contact

      Navigator.of(context).pop(); // Close the modal after submission
    }
  }

  // Helper to build input fields with a consistent style.
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isOptional = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
      validator:
          (value) =>
              (!isOptional && (value == null || value.isEmpty))
                  ? 'Please enter $label'
                  : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              widget.contact == null ? 'Create Contact' : 'Edit Contact',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _firstNameController,
              label: 'First Name',
              icon: Icons.person,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _lastNameController,
              label: 'Last Name',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone',
              icon: Icons.phone,
            ),
            const Divider(height: 30),
            // Address section header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Address',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _addressLineController,
              label: 'Address Line',
              icon: Icons.home,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _cityController,
              label: 'City',
              icon: Icons.location_city,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _postalCodeController,
              label: 'Postal Code',
              icon: Icons.markunread_mailbox,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _countryController,
              label: 'Country',
              icon: Icons.map,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _additionalController,
              label: 'Additional Details',
              icon: Icons.info_outline,
              isOptional: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.save),
              label: const Text('Save Contact'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class HomeScreen1 extends StatelessWidget {
  final List<Contact> contacts;
  const HomeScreen1({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
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
                  builder: (context) => ContactDetailsScreen(contact: contact),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              'Total contacts: ${contacts.length}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;
  const ContactDetailsScreen({super.key, required this.contact});

  Future<void> _launchMaps(String query) async {
    final launchUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}',
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${contact.firstName} ${contact.lastName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email: ${contact.email}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone: ${contact.phone}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Address: ${contact.address.fullAddress}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _launchMaps(contact.address.fullAddress),
              child: const Text('Navigate in Google Maps'),
            ),
          ],
        ),
      ),
    );
  }
}
