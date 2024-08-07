import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_tracker/pages/food_tracking_pages/foodpage.dart';
import 'package:workout_tracker/pages/homepage_pages/homepage.dart';
import 'package:workout_tracker/pages/stress_tracking_pages/stresspage.dart';
import 'package:workout_tracker/utilities/custom_navigation_bar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CalorieTracking(),
    const StressTracking(),
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
          'assets/images/gym-c.png',
          'assets/images/food-c.png',
          'assets/images/lotus-c.png',
        ],
        onTap: _onItemTapped,
        selectedIconColors: const [
          Colors.orange, // HomePage icon color
          Colors.blue, // CalorieTracking icon color
          Colors.purple, // StressTracking icon color
        ],
      ),
    );
  }
}
