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
      body: SafeArea(
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
    );
  }
}
