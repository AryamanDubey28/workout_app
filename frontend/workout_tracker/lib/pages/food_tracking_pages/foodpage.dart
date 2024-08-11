import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/food_tracking_pages/date_cards.dart';
import 'package:workout_tracker/pages/food_tracking_pages/food_entry.dart';
import 'package:workout_tracker/pages/food_tracking_pages/nutritional_summary.dart';
import 'package:workout_tracker/pages/food_tracking_pages/water_tracking.dart';

class CalorieTracking extends StatelessWidget {
  const CalorieTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // body: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       // end: Alignment.center,
      //       end: Alignment.bottomCenter,
      //       colors: [
      //         Colors.blue,
      //         Color.fromARGB(255, 86, 194, 244),
      //         Color.fromARGB(255, 116, 202, 242),
      //         Color.fromARGB(255, 183, 229, 250),
      //         Color.fromARGB(255, 206, 236, 250),
      //         Colors.white,
      //       ],
      //     ),
      //   ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateCards(
                  title: "Food Tracking Insights",
                ),
                SizedBox(height: 5),
                NutritionalSummary(), // Placeholder for your actual widget
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                FoodEntrySection(
                  title: 'Breakfast',
                  calories: '272 kcal',
                  imagePath: 'assets/images/fruits.png',
                ),
                FoodEntrySection(
                  title: 'Lunch',
                  calories: '477 kcal',
                  imagePath: 'assets/images/lunch-bag.png',
                ),
                FoodEntrySection(
                  title: 'Dinner',
                  calories: '650 kcal',
                  imagePath: 'assets/images/dinner.png',
                ),
                WaterTrackingSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
