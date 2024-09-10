import 'dart:convert';
import 'api_client.dart';

class JournalService {
  final ApiClient _apiClient;

  JournalService(this._apiClient);

  Future<Map<String, dynamic>> createJournalEntry(
      String userId, int stressLevel, String content) async {
    final response = await _apiClient.post(
      '/journal/$userId',
      body: {
        'stress_level': stressLevel,
        'content': content,
      },
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create journal entry');
    }
  }

  Future<List<Map<String, dynamic>>> getJournalEntries(String userId) async {
    final response = await _apiClient.get('/journal/$userId');
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load journal entries');
    }
  }

  Future<Map<String, dynamic>> getJournalEntry(
      String userId, int entryId) async {
    final response = await _apiClient.get('/journal/$userId/$entryId');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load journal entry');
    }
  }

  Future<void> updateJournalEntry(String userId, int entryId,
      {int? stressLevel, String? content}) async {
    final response = await _apiClient.put(
      '/journal/$userId/$entryId',
      body: {
        if (stressLevel != null) 'stress_level': stressLevel,
        if (content != null) 'content': content,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update journal entry');
    }
  }

  Future<void> deleteJournalEntry(String userId, int entryId) async {
    final response = await _apiClient.delete('/journal/$userId/$entryId');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete journal entry');
    }
  }
}
