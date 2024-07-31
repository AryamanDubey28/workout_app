import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/homepage_pages/create_exercise_screen.dart';
import 'package:workout_tracker/pages/homepage_pages/exercise_card.dart';
import 'package:workout_tracker/utilities/platform_specific_button.dart';

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
                  const SizedBox(height: 20),
                  PlatformSpecificButton(
                    color: CupertinoColors.systemGreen,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateExerciseScreen(),
                        ),
                      );
                    },
                    child: const Text('Create Exercise'),
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
