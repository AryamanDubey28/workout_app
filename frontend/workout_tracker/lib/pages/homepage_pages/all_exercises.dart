import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/homepage_pages/exercise_card.dart';
import 'package:workout_tracker/services/api_client.dart';
import 'package:workout_tracker/services/exercise_service.dart';

class AllExercisesScreen extends StatefulWidget {
  const AllExercisesScreen({super.key});

  @override
  State<AllExercisesScreen> createState() => _AllExercisesScreenState();
}

class _AllExercisesScreenState extends State<AllExercisesScreen> {
  late final ExerciseService exerciseService;

  @override
  void initState() {
    super.initState();
    exerciseService =
        ExerciseService(ApiClient(baseUrl: 'http://127.0.0.1:5000'));
  }

  Future<List<Map<String, dynamic>>> _fetchExercises() async {
    try {
      return await exerciseService.getExercises();
    } catch (e) {
      // You might want to log the error here
      rethrow; // Rethrow to let FutureBuilder handle it
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Exercises'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchExercises(), // Fetch exercises
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
