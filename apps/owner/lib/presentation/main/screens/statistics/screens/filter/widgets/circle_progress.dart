import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CircleProgress extends CustomPainter {
  final double radius;
  final Color mainColor;
  final Color arcColor;
  final double strokeWidth;
  final double percentage;

  CircleProgress(
      {required this.radius,
      required this.mainColor,
      required this.arcColor,
      required this.strokeWidth,
      required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    //paint circle
    Paint circle = Paint()
      ..strokeWidth = strokeWidth
      ..color = mainColor
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, circle);

    //paint animation arc
    Paint arc = Paint()
      ..strokeWidth = strokeWidth
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double angle = 2 * pi * (percentage / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi, angle, false, arc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
