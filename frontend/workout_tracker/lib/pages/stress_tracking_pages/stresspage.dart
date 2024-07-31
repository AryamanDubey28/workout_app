import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/food_tracking_pages/date_cards.dart';
import 'package:workout_tracker/pages/stress_tracking_pages/journal.dart';
import 'package:workout_tracker/pages/stress_tracking_pages/meditation_page.dart';
import 'package:workout_tracker/pages/stress_tracking_pages/stress_graph.dart';

class StressTracking extends StatelessWidget {
  const StressTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color.fromARGB(255, 166, 82, 245), // Dark purple
              Color.fromARGB(255, 197, 130, 244), // Medium purple
              Color.fromARGB(255, 217, 153, 249), // Light purple
              Color.fromARGB(255, 229, 191, 248), // Very light purple
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DateCards(
                    title: "Stress Tracking Insights",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StressGraph(),
                  const SizedBox(height: 20),
                  const MeditationCard(),
                  const SizedBox(height: 20),
                  const JournalCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
