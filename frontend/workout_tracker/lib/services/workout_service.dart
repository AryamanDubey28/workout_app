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
}
