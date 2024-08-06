import 'dart:math';

import 'package:flutter/material.dart';

class WorkoutDisplay extends StatelessWidget {
  final Map<String, dynamic> workout;

  const WorkoutDisplay({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    // Define the colors for the tiles
    const Color tileColor1 = Colors.orange;
    const Color tileColor2 = Colors.orangeAccent; // More mustard-like yellow
    const Color tileColor3 = Colors.red;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with gradient and add button
              Container(
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
                      icon: const Icon(Icons.add_circle,
                          color: Colors.orange, size: 44),
                      onPressed: () {
                        // Add button functionality can be implemented later
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),

              // Row of tiles with added padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildColorTile(tileColor1, '60 KG'),
                    const SizedBox(width: 8), // Add space between tiles
                    _buildColorTile(tileColor2, '3500 Kcal'),
                    const SizedBox(width: 8), // Add space between tiles
                    _buildColorTile(tileColor3, 'Done?'),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Section with 3 widgets, including workout details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildStepsWidget(), // Method for 1200 Steps widget
                            const SizedBox(height: 8),
                            _buildThisWeekWidget(), // Method for This Week widget
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
              ),
            ],
          ),
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
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
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
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Center(
          child: Text(
            '1200 Steps',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
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
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'This Week',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: BarChart(), // Add the bar chart widget
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Average',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '9987 Steps', // Placeholder value
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
      decoration: BoxDecoration(
        color: Colors.orange, // Retain original tile color
        borderRadius: BorderRadius.circular(
            12.0), // Increase border radius for softer corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Add subtle shadow
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Workout Plan',
              style: TextStyle(
                color: Colors.white, // Use original text color
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: workout.values.length,
                itemBuilder: (context, index) {
                  return Text(
                    '${workout.values.elementAt(index)}',
                    style: const TextStyle(
                      color: Colors
                          .white, // Keep the original white text color for values
                      fontSize: 18,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors
                      .white24, // Use a lighter divider color for subtle separation
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

class BarChart extends StatelessWidget {
  const BarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BarChartPainter(),
      child: Container(),
    );
  }
}

class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final barWidth = size.width / 8;
    final random = Random();

    for (int i = 0; i < 7; i++) {
      final barHeight = random.nextDouble() * size.height * 0.6;
      final left = i * (barWidth + 8); // Space between bars
      final top = size.height - barHeight;
      final right = left + barWidth;
      final bottom = size.height;

      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
