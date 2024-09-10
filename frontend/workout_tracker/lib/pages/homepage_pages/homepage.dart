import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/homepage_pages/workout_display.dart';
import 'package:workout_tracker/services/api_client.dart';
import 'package:workout_tracker/services/workout_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WorkoutService workoutService;
  late Future<Map<String, dynamic>> _workout;

  @override
  void initState() {
    super.initState();
    workoutService =
        WorkoutService(ApiClient(baseUrl: 'http://127.0.0.1:5000'));
    _workout = _fetchWorkout();
  }

  Future<Map<String, dynamic>> _fetchWorkout() async {
    try {
      return await workoutService.fetchWorkout();
    } catch (e) {
      // You might want to log the error here
      print(e.toString());
      rethrow; // Rethrow to let FutureBuilder handle it
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _workout,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            } else if (snapshot.hasData) {
              return WorkoutDisplay(workout: snapshot.data!);
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String message;

  const ErrorWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, color: Colors.red, size: 48),
        const SizedBox(height: 16),
        Text(message, style: const TextStyle(color: Colors.red, fontSize: 16)),
      ],
    );
  }
}
