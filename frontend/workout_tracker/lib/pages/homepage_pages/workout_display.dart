import 'package:flutter/material.dart';

class WorkoutDisplay extends StatelessWidget {
  final Map<String, dynamic> workout;

  const WorkoutDisplay({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 11, 242, 19),
                  Color.fromARGB(255, 69, 241, 75),
                  Color.fromARGB(255, 126, 243, 130),
                  Color.fromARGB(255, 183, 247, 185),
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const SafeArea(
              child: Center(
                child: Text(
                  'Workout',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExerciseCard(
                    icon: Icons.fitness_center,
                    title: 'Pushup',
                    description: workout['pushup'],
                  ),
                  ExerciseCard(
                    icon: Icons.fitness_center,
                    title: 'Pullup',
                    description: workout['pullup'],
                  ),
                  ExerciseCard(
                    icon: Icons.fitness_center,
                    title: 'Squat',
                    description: workout['squat_lunge'],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ExerciseCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
          size: 40,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
