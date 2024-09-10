import 'dart:convert';
import 'api_client.dart';

class ExerciseService {
  final ApiClient _apiClient;

  ExerciseService(this._apiClient);

  Future<Map<String, dynamic>> addExercise(
      String name, List<String> musclesWorked,
      {double? weight}) async {
    final response = await _apiClient.post(
      '/exercise',
      body: {
        'name': name,
        'musclesWorked': musclesWorked,
        'weight': weight,
      },
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add exercise');
    }
  }

  Future<List<Map<String, dynamic>>> getExercises() async {
    final response = await _apiClient.get('/exercise');
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load exercises');
    }
  }
}
