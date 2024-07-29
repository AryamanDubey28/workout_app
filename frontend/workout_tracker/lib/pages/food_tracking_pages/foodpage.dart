import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker/pages/food_tracking_pages/food_entry.dart';
import 'package:workout_tracker/pages/food_tracking_pages/nutritional_summary.dart';
import 'package:workout_tracker/pages/food_tracking_pages/water_tracking.dart';

class CalorieTracking extends StatelessWidget {
  const CalorieTracking({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the current day of the week and set up date formatting
    final DateTime today = DateTime.now();
    final DateFormat dayFormatter =
        DateFormat('EEE'); // Format for day abbreviations
    final DateFormat numericDayFormatter =
        DateFormat('d'); // Format for numeric day
    final List<DateTime> weekDays = List.generate(
        5,
        (index) => DateTime(
            today.year, today.month, today.day + index - today.weekday + 1));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Weekdays',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {}, // Calendar icon action
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: weekDays.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      bool isToday = weekDays[index].day == today.day;
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                              color: isToday ? Colors.blue : Colors.transparent,
                              width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                numericDayFormatter.format(weekDays[index]),
                                style: TextStyle(
                                    color: isToday ? Colors.blue : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                dayFormatter.format(weekDays[index]),
                                style: TextStyle(
                                    color:
                                        isToday ? Colors.blue : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const NutritionalSummary(),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const FoodEntrySection(
                  title: 'Breakfast',
                  calories: '272 kcal',
                  imagePath: 'assets/images/fruits.png',
                ),
                const FoodEntrySection(
                  title: 'Lunch',
                  calories: '477 kcal',
                  imagePath: 'assets/images/lunch-bag.png',
                ),
                const FoodEntrySection(
                  title: 'Dinner',
                  calories: '650 kcal',
                  imagePath: 'assets/images/dinner.png',
                ),
                const SizedBox(height: 2),
                const WaterTrackingSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
