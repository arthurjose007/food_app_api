import 'package:flutter/material.dart';
import 'package:food_app_api/views/home.dart';
import 'package:food_app_api/views/menu.dart';
import 'package:food_app_api/views/profile.dart';

class bottomnavigation extends StatefulWidget {
  const bottomnavigation({super.key});

  @override
  State<bottomnavigation> createState() => _bottomnavigationState();
}

class _bottomnavigationState extends State<bottomnavigation> {
  int _selectedinderx = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetoptions = <Widget>[
    HomePage(),
    //MenuApp(),
    MealsPage(),
    //Text("data"),

    ProfilePage()
  ];
  void _onitemTapped(int index) {
    setState(() {
      _selectedinderx = index;
    });
  }

  List title = [
    "Home",
    "Menu",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.import_contacts),
        title: Text(title[_selectedinderx]),
        actions: const [Icon(Icons.more_vert)],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_sharp),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profiler',
          ),
        ],
        currentIndex: _selectedinderx,
        onTap: _onitemTapped,
        //selectedIconTheme: IconThemeData(color: Colors.green),
        selectedItemColor: Colors.green,
      ),
      body: Center(
        child: _widgetoptions.elementAt(_selectedinderx),
      ),
    );
  }
}
