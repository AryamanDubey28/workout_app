import 'package:flutter/material.dart';

class MeditationCard extends StatelessWidget {
  const MeditationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MeditationPage()),
        );
      },
      child: Card(
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
                'Meditation and Breathing Exercises',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Find time to relax and unwind with these guided meditations and breathing exercises.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation and Breathing Exercises'),
      ),
      body: const Center(
        child: Text('Dummy Text'),
      ),
    );
  }
}
