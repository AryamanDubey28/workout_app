import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://127.0.0.1:5000';

  Future<Map<String, dynamic>> fetchWorkout() async {
    final response = await http.get(Uri.parse('$baseUrl/workout'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load workout');
    }
  }

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

  Future<List<Map<String, dynamic>>> fetchExercises() async {
    final response = await http.get(Uri.parse('$baseUrl/exercises'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load exercises');
    }
  }
}
