import 'package:flutter/material.dart';

class WorkoutStyles {
  static const Color tileColor1 = Colors.orange;
  static const Color tileColor2 = Colors.orangeAccent;
  static const Color tileColor3 = Colors.red;
  static const Color stepsColor = Colors.red;
  static const Color thisWeekColor = Colors.orangeAccent;
  static const Color workoutDetailsColor = Colors.orange;

  static const TextStyle tileTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle widgetTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle widgetTitleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle dailyAverageTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle dailyAverageValueTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static const TextStyle workoutPlanTitleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle workoutValueTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  static const List<BoxShadow> boxShadow = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const BorderRadius borderRadius =
      BorderRadius.all(Radius.circular(12.0));
}
