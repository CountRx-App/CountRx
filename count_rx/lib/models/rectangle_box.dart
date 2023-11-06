import 'package:flutter/material.dart';

class RectangleBox extends CustomPainter {
  final Rect r;
  final Image image;

  RectangleBox({
    required this.r,
    required this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.red;

    Rect scaledRect = Rect.fromLTRB(
      r.left / 10,
      r.top / 10,
      r.right / 10,
      r.bottom / 10,
    );

    canvas.drawRect(
      scaledRect,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
