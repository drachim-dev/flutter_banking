import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = 28;
    final paint = Paint()
      ..color = Colors.blue[100]
      ..strokeWidth = 2.0;

    canvas.translate(0.0, height);
    canvas.drawLine(Offset(0, 0), Offset(10, -10), paint);
    canvas.drawLine(Offset(10, -10), Offset(20, -30), paint);
    canvas.drawLine(Offset(20, -30), Offset(30, -25), paint);
    canvas.drawLine(Offset(30, -25), Offset(40, -20), paint);
    canvas.drawLine(Offset(40, -20), Offset(50, -30), paint);
    canvas.drawLine(Offset(50, -30), Offset(60, -32), paint);
    canvas.drawLine(Offset(60, -32), Offset(70, -25), paint);
    canvas.drawLine(Offset(70, -25), Offset(80, -20), paint);
    canvas.drawLine(Offset(80, -20), Offset(90, -25), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}