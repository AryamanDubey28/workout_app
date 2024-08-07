import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/homepage_pages/barchart.dart';
import 'package:workout_tracker/pages/homepage_pages/workout_styles.dart';

class WorkoutDisplay extends StatelessWidget {
  final Map<String, dynamic> workout;

  const WorkoutDisplay({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 5),
              _buildTileRow(),
              const SizedBox(height: 10),
              _buildMainContent(),
            ],
          ),
        ),
      ),
    );
  }

  // Header with title and add button
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Workout',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: <Color>[Colors.orange, Colors.red],
                  ).createShader(
                    const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                  ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.orange, size: 44),
            onPressed: () {
              // Add button functionality can be implemented later
            },
          ),
        ],
      ),
    );
  }

  // Row of tiles with labels
  Widget _buildTileRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildColorTile(WorkoutStyles.tileColor1, '60 KG'),
          const SizedBox(width: 8),
          _buildColorTile(WorkoutStyles.tileColor2, '3500 Kcal'),
          const SizedBox(width: 8),
          _buildColorTile(WorkoutStyles.tileColor3, 'Done?'),
        ],
      ),
    );
  }

  // Main content area with widgets
  Widget _buildMainContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildStepsWidget(),
                  const SizedBox(height: 8),
                  _buildThisWeekWidget(),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildWorkoutDetailsBox(workout),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a colored tile with a label
  Widget _buildColorTile(Color color, String label) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: WorkoutStyles.borderRadius,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: WorkoutStyles.tileTextStyle,
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build the 1200 Steps widget
  Widget _buildStepsWidget() {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: const BoxDecoration(
          color: WorkoutStyles.stepsColor,
          borderRadius: WorkoutStyles.borderRadius,
        ),
        child: const Center(
          child: Text(
            '1200 Steps',
            style: WorkoutStyles.widgetTextStyle,
          ),
        ),
      ),
    );
  }

  // Helper method to build the This Week widget with a title
  Widget _buildThisWeekWidget() {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: const BoxDecoration(
          color: WorkoutStyles.thisWeekColor,
          borderRadius: WorkoutStyles.borderRadius,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'This Week',
                style: WorkoutStyles.widgetTitleTextStyle,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: BarChart(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Color.fromARGB(60, 64, 63, 63),
                    thickness: 1,
                  ),
                  Text(
                    'Daily Average',
                    style: WorkoutStyles.dailyAverageTextStyle,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '9987 Steps', // Placeholder value
                    style: WorkoutStyles.dailyAverageValueTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the workout details box
  Widget _buildWorkoutDetailsBox(Map<String, dynamic> workout) {
    return Container(
      decoration: const BoxDecoration(
        color: WorkoutStyles.workoutDetailsColor,
        borderRadius: WorkoutStyles.borderRadius,
        boxShadow: WorkoutStyles.boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Workout Plan',
              style: WorkoutStyles.workoutPlanTitleTextStyle,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: workout.values.length,
                itemBuilder: (context, index) {
                  return Text(
                    '${workout.values.elementAt(index)}',
                    style: WorkoutStyles.workoutValueTextStyle,
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.white24,
                  thickness: 1,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
