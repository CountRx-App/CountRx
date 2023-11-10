import 'dart:io';

import 'package:count_rx/components/flexible_button.dart';
import 'package:count_rx/components/overlaid_image.dart';
import 'package:count_rx/managers/auth_manager.dart';
import 'package:count_rx/managers/pill_count_collection_manager.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    countController.text = widget.detectedObjects.length.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      hintText: "Optional name for the history entry",
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: countController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Count",
                      hintText: "Number of pills",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please input a number";
                      }

                      final int? count = int.tryParse(value);
                      if (count == null) {
                        return "Please input a number";
                      } else if (count < 0) {
                        return "Please input a positive number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  FlexibleButton(
                    buttonText: "Submit and Take New Picture",
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: upload the image to firebase

                        PillCountCollectionManager.instance.add(
                          name: nameController.text,
                          count: int.parse(countController.text),
                          timestamp: DateTime.now(),
                          // TODO: Add url here when firebase storage is implemented (replace the discord url)
                          imageUrl:
                              "https://media.discordapp.net/attachments/787793633943748613/1170898777306038302/rn_image_picker_lib_temp_44c559ea-3c45-49a9-838d-d432929298fc.jpg?ex=655ab776&is=65484276&hm=5b6ec0c99be67de9db1a684727c82e14ae1d14daf079ec38a4df79c6bd1cd1a8&=&width=1248&height=1664",
                          authorUid: AuthManager.instance.uid,
                        );
                      }
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
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
