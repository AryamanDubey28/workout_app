import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://127.0.0.1:5000';

  // Fetch the workout for today
  Future<Map<String, dynamic>> fetchWorkout() async {
    final response = await http.get(Uri.parse('$baseUrl/workout'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load workout');
    }
  }

  // Add a new exercise
  Future<void> addExercise(String name, List<String> musclesWorked,
      {double? weight}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_exercise'),
      headers: {'Content-Type': 'application/json'},
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

  // Fetch all exercises
  Future<List<Map<String, dynamic>>> fetchExercises() async {
    final response = await http.get(Uri.parse('$baseUrl/exercises'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  // Create a new user
  Future<Map<String, dynamic>> createUser(
      int age, String gender, double height, double weight) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user'),
      headers: {'Content-Type': 'application/json'},
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

  // Update an existing user
  Future<void> updateUser(int userId,
      {int? age,
      String? gender,
      double? height,
      double? weight,
      int? stepsTaken,
      bool? workedOutToday}) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/$userId'),
      headers: {'Content-Type': 'application/json'},
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

  // Log a run for a user
  Future<Map<String, dynamic>> logRun(int userId,
      {double? distanceKm, double? timeMinutes}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/$userId/log_run'),
      headers: {'Content-Type': 'application/json'},
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
}
