import 'dart:io';

import 'package:count_rx/components/overlaid_image.dart';
import 'package:flutter/material.dart';
import 'package:learning_object_detection/learning_object_detection.dart';

class PreviewPage extends StatefulWidget {
  final String imagePath;
  final List<DetectedObject> detectedObjects;
  final double aspectRatio;

  const PreviewPage({
    super.key,
    required this.imagePath,
    required this.detectedObjects,
    required this.aspectRatio,
  });

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    textController.text = widget.detectedObjects.length.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OverlaidImage(
            image: Image.file(
              File(widget.imagePath),
              height: 400,
              width: 400 * widget.aspectRatio,
            ),
            rects: _getRects(),
          ),
          // SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Text',
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Rect> _getRects() {
    List<Rect> rects = [];
    for (final d in widget.detectedObjects) {
      rects.add(
        d.boundingBox,
      );
    }

    return rects;
  }
}
