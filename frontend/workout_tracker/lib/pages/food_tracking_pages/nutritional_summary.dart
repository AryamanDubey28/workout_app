import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class NutritionalSummary extends StatefulWidget {
  const NutritionalSummary({super.key});

  @override
  _NutritionalSummaryState createState() => _NutritionalSummaryState();
}

class _NutritionalSummaryState extends State<NutritionalSummary>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '1139 kcal left',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CircularPercentIndicator(
                    radius: MediaQuery.of(context).size.width / 2.5,
                    lineWidth: 20.0,
                    percent: _animation.value,
                    center: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NutritionalInfo(
                          label: 'Carbs',
                          value: '122 / 249 g',
                        ),
                        NutritionalInfo(
                          label: 'Protein',
                          value: '38 / 69 g',
                        ),
                        NutritionalInfo(
                          label: 'Fat',
                          value: '39 / 79 g',
                        ),
                      ],
                    ),
                    backgroundColor: Colors.grey[300]!,
                    progressColor: Colors.blue,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionalInfo extends StatelessWidget {
  final String label;
  final String value;

  const NutritionalInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
