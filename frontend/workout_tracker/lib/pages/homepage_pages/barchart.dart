import 'dart:math';

import 'package:flutter/material.dart';

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
      final left = i * (barWidth + 8);
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
