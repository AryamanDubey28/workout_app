import 'dart:convert';
import 'api_client.dart';

class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  Future<void> createUserInBackend(
      String uid, String age, String email, String userName) async {
    final response = await _apiClient.post(
      '/auth/user',
      body: {
        'age': int.parse(age),
        'email': email,
        'user_name': userName,
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create user in backend');
    }
  }

  Future<int> fetchStreak(String userId) async {
    final response = await _apiClient.get('/user/$userId/streak');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['streak'];
    } else {
      throw Exception('Failed to load streak');
    }
  }

  Future<void> updateUser(String userId,
      {int? age,
      String? email,
      String? user_name,
      String? gender,
      double? height,
      double? weight,
      int? stepsTaken,
      bool? workedOutToday}) async {
    final response = await _apiClient.put(
      '/user/$userId',
      body: {
        if (age != null) 'age': age,
        if (email != null) 'email': email,
        if (user_name != null) 'user_name': user_name,
        if (gender != null) 'gender': gender,
        if (height != null) 'height': height,
        if (weight != null) 'weight': weight,
        if (stepsTaken != null) 'steps_taken': stepsTaken,
        if (workedOutToday != null) 'worked_out_today': workedOutToday,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<Map<String, dynamic>> logRun(String userId,
      {double? distanceKm, double? timeMinutes}) async {
    final response = await _apiClient.post(
      '/user/$userId/log_run',
      body: {
        'distance_km': distanceKm,
        'time_minutes': timeMinutes,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to log run');
    }
  }
}
