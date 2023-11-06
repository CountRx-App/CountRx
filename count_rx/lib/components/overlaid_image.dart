import 'package:count_rx/models/rectangle_box.dart';
import 'package:flutter/material.dart';

class OverlaidImage extends StatelessWidget {
  final List<Rect> rects;
  final Image image;

  const OverlaidImage({
    super.key,
    required this.rects,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: _drawrectangles(),
      ),
    );
  }

  List<Widget> _drawrectangles() {
    List<Widget> widgets = [image];

    for (final r in rects) {
      widgets.add(
        Positioned(
          top: r.top / image.height!,
          left: r.left / image.width!,
          child: CustomPaint(
            painter: RectangleBox(r: r, image: image),
            child: Container(),
          ),
        ),
      );
    }

    print("${widgets.toString()}");

    return widgets;
  }
}
