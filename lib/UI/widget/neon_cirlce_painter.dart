import 'dart:math' as math;
import 'package:flutter/material.dart';

class NeonCirclePainter extends CustomPainter {
  final double progress;
  NeonCirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // Base circle
    final basePaint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - 10, basePaint);

    // Gradient arc
    final arcPaint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Colors.tealAccent,
          Colors.pinkAccent,
          Colors.purpleAccent,
          Colors.tealAccent,
        ],
        startAngle: 0,
        endAngle: 2 * math.pi,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweep = 2 * math.pi * (progress % 1);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 10),
      -math.pi / 2,
      sweep,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant NeonCirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
