import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/homepage_pages/exercise_card.dart';
import 'package:workout_tracker/services/workout_service.dart';

class AllExercisesScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  AllExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Exercises'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: apiService.fetchExercises(), // Fetch exercises
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No exercises found.'));
          } else {
            // Display the list of exercises
            final exercises = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return ExerciseCard(
                  icon: Icons.fitness_center,
                  title: exercise['name'],
                  description: (exercise['musclesWorked'] as List).join(', '),
                );
              },
            );
          }
        },
      ),
    );
  }
}
