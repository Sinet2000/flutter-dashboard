import 'package:flutter/material.dart';
import 'package:my_first_app/config/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedNavIdx = 0;

  // Pages for navigation
  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Contacts Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Projects Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Account Page', style: TextStyle(fontSize: 24))),
  ];

  void _onNavBarItemSelected(int index) {
    setState(() {
      _selectedNavIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primarySwatch[800],
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedNavIdx],
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
