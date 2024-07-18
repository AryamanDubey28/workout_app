import 'package:flutter/material.dart';
import 'package:workout_tracker/services/workout_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();

  Future<Map<String, dynamic>>? _workout;

  @override
  void initState() {
    super.initState();
    _workout = apiService.fetchWorkout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Generator'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _workout,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final workout = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Pushup: ${workout['pushup']}'),
                  Text('Pullup: ${workout['pullup']}'),
                  Text('Squat/Lunge: ${workout['squat_lunge']}'),
                ],
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}
