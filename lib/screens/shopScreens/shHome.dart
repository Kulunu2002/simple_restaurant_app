import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/shComponents/shHomeCom.dart';
import 'package:food_app/screens/shopScreens/shProfile.dart';

class ShHome extends StatefulWidget {
  const ShHome({super.key});

  @override
  State<ShHome> createState() => _ShHomeState();
}

class _ShHomeState extends State<ShHome> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const ShHomeCom(),
    const Text('Messages'),
    const ShProfile()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    ));
  }
}