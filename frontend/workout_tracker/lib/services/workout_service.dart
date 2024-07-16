import 'dart:convert';
import 'package:http/http.dart' as http;

// Interact with REST API

Future<Map<String, String>> fetchWorkout() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:5000/workout'));

  if (response.statusCode == 200) {
    return Map<String, String>.from(json.decode(response.body));
  } else {
    throw Exception('Failed to load workout');
  }
}
