import 'dart:convert';
import 'api_client.dart';

class StepsService {
  final ApiClient _apiClient;

  StepsService(this._apiClient);

  Future<void> addOrUpdateSteps(String userId, int steps, String date) async {
    final response = await _apiClient.post(
      '/user/$userId/steps',
      body: {
        'date': date,
        'steps': steps,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add/update steps');
    }
  }

  Future<List<Map<String, dynamic>>> fetchStepsHistory(String userId) async {
    final response = await _apiClient.get('/user/$userId/steps');
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load steps history');
    }
  }
}
