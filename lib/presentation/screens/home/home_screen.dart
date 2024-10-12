import 'package:adopme_frontend/presentation/screens/pet/register_pet/register_pet_screen.dart';
import 'package:flutter/material.dart';
import '../other_page.dart';
import '../../widgets/bottom_nav_bar.dart';


class HomeScreen extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    OtherPage(),
    OtherPage(),
    RegisterPetScreen(),
    OtherPage(),
    OtherPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
