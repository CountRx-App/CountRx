import 'dart:io';

import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  final String imagePath;

  const PreviewPage({
    super.key,
    required this.imagePath,
  });

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(
            File(widget.imagePath),
            height: 200,
            width: 200,
          ),
          SizedBox(height: 20),
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
}
