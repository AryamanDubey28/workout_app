import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Stress Summary'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Weekly Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Average Stress Level',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your average stress level this week is: [Insert Average Stress Level Here]',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Stress Levels',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Monday: [Insert Stress Level Here]',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Tuesday: [Insert Stress Level Here]',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Wednesday: [Insert Stress Level Here]',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Thursday: [Insert Stress Level Here]',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Friday: [Insert Stress Level Here]',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Saturday: [Insert Stress Level Here]',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Sunday: [Insert Stress Level Here]',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
