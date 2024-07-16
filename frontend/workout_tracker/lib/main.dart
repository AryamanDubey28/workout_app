import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/foodpage.dart';
import 'package:workout_tracker/pages/homepage.dart';
import 'package:workout_tracker/pages/profilepage.dart';
import 'package:workout_tracker/pages/stresspage.dart';
import 'package:workout_tracker/utilities/custom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Navbar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CalorieTracking(),
    StressTracking(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        items: const <String>[
          'assets/images/home.png',
          'assets/images/food.png',
          'assets/images/stress.png',
          'assets/images/profile.png',
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
