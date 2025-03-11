import 'package:flutter/material.dart';
import 'package:my_first_app/config/colors.dart';
import 'package:my_first_app/core/models/contact_model.dart';
import 'package:my_first_app/presentation/screens/contacts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedNavIdx = 0;

  List<Contact> contacts = [
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

  void _onNavBarItemSelected(int index) {
    setState(() {
      _selectedNavIdx = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(microseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedNavIdx = index;
    });
  }

  void _addContact(Contact newContact) {
    setState(() {
      contacts.add(newContact);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedNavIdx);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
      ContactsPage(contacts: contacts, onAddContact: _addContact),
      Center(child: Text('Projects Page', style: TextStyle(fontSize: 24))),
      Center(child: Text('Account Page', style: TextStyle(fontSize: 24))),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primarySwatch[800],
        foregroundColor: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20), // Subtle shadow
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ), // Rounded top corners
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedNavIdx,
          onTap: _onNavBarItemSelected,
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              Colors.transparent, // Transparent to show container styling
          elevation: 0, // No extra elevation (handled by container shadow)
          selectedItemColor: primarySwatch[500],
          unselectedItemColor: Colors.grey[500],
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          // splashColor: Colors.blueAccent.withAlpha(51), // 20% opacity ripple
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone, size: 28),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work, size: 28),
              label: 'Projects',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 28),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
