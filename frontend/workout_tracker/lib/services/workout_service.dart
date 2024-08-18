import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:5000';

  // Method to get the Firebase ID token
  Future<String?> _getIdToken({bool requireAuth = true}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await user.getIdToken();
    } else if (requireAuth) {
      throw Exception('No user logged in');
    } else {
      return null;
    }
  }

  // Fetch the workout for today (Requires Authorization)
  Future<Map<String, dynamic>> fetchWorkout() async {
    final idToken = await _getIdToken();
    final response = await http.get(
      Uri.parse('$baseUrl/workout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load workout');
    }
  }

  // Update the 'worked_out_today' field for the user
  Future<void> markWorkoutCompleted(String userId) async {
    final idToken = await _getIdToken();
    final response = await http.put(
      Uri.parse('$baseUrl/user/$userId/update_workout_status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: json.encode({
        'worked_out_today': true,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update workout status');
    }
  }

  Future<int> fetchStreak(String userId) async {
    final idToken = await _getIdToken();
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userId/streak'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['streak'];
    } else {
      throw Exception('Failed to load streak');
    }
  }

  // Add a new exercise (Might require authorization based on your app's logic)
  Future<void> addExercise(String name, List<String> musclesWorked,
      {double? weight}) async {
    final idToken = await _getIdToken();
    final response = await http.post(
      Uri.parse('$baseUrl/add_exercise'),
      headers: {
        'Content-Type': 'application/json',
        if (idToken != null) 'Authorization': 'Bearer $idToken',
      },
      body: json.encode({
        'name': name,
        'musclesWorked': musclesWorked,
        'weight': weight,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add exercise');
    }
  }

  // Fetch all exercises (Might not require authorization if public)
  Future<List<Map<String, dynamic>>> fetchExercises() async {
    final response = await http.get(
      Uri.parse('$baseUrl/exercises'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  // Create a new user (Requires Authorization)
  Future<Map<String, dynamic>> createUser(
      int age, String gender, double height, double weight) async {
    final idToken = await _getIdToken();
    final response = await http.post(
      Uri.parse('$baseUrl/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: json.encode({
        'age': age,
        'gender': gender,
        'height': height,
        'weight': weight,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create user');
    }
  }

  // Update an existing user (Requires Authorization)
  Future<void> updateUser(String userId,
      {int? age,
      String? gender,
      double? height,
      double? weight,
      int? stepsTaken,
      bool? workedOutToday}) async {
    final idToken = await _getIdToken();
    final response = await http.put(
      Uri.parse('$baseUrl/user/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: json.encode({
        'age': age,
        'gender': gender,
        'height': height,
        'weight': weight,
        'steps_taken': stepsTaken,
        'worked_out_today': workedOutToday,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  // Log a run for a user (Requires Authorization)
  Future<Map<String, dynamic>> logRun(String userId,
      {double? distanceKm, double? timeMinutes}) async {
    final idToken = await _getIdToken();
    final response = await http.post(
      Uri.parse('$baseUrl/user/$userId/log_run'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: json.encode({
        'distance_km': distanceKm,
        'time_minutes': timeMinutes,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to log run');
    }
  }

  Future<void> addOrUpdateSteps(String userId, int steps, String date) async {
    final idToken = await _getIdToken();
    final response = await http.post(
      Uri.parse('$baseUrl/user/$userId/steps'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
      body: json.encode({
        'date': date,
        'steps': steps,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add/update steps');
    }
  }

  Future<List<Map<String, dynamic>>> fetchStepsHistory(String userId) async {
    final idToken = await _getIdToken();
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userId/steps'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load steps history');
    }
  }
}
