import 'dart:io';

import 'package:count_rx/main.dart';
import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_object_detection/learning_object_detection.dart';

import 'preview_page.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const CameraPage({
    super.key,
    required this.cameras,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras![0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _takePictureAndNavigate() async {
    try {
      controller.setFlashMode(FlashMode.off);

      final XFile picture = await controller.takePicture();

      InputImage image = InputImage.fromFile(File(picture.path));

      double aspectRatio = controller.value.aspectRatio;

      List<DetectedObject> detectedObjects =
          await counter.detector.detect(image);

      // print("Detected objects: ${detectedObjects.length}");

      // print(await counter.count(image: image));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(
            imagePath: picture.path,
            detectedObjects: detectedObjects,
            aspectRatio: aspectRatio,
          ),
        ),
      );
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: CameraPreview(controller),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePictureAndNavigate,
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return InputCameraView(
  //     cameraDefault: InputCameraType.rear,
  //     // resolutionPreset: ResolutionPreset.high,
  //     title: 'Object Detection & Tracking',
  //     onImage: _takePictureAndNavigate,
  //     overlay: Consumer<ObjectDetectionState>(
  //       builder: (_, state, __) {
  //         if (state.isEmpty) {
  //           return Container();
  //         }

  //         Size originalSize = state.size!;
  //         Size size = MediaQuery.of(context).size;

  //         // if image source from gallery
  //         // image display size is scaled to 360x360 with retaining aspect ratio
  //         if (state.notFromLive) {
  //           if (originalSize.aspectRatio > 1) {
  //             size = Size(360.0, 360.0 / originalSize.aspectRatio);
  //           } else {
  //             size = Size(360.0 * originalSize.aspectRatio, 360.0);
  //           }
  //         }

  //         return ObjectOverlay(
  //           size: size,
  //           originalSize: originalSize,
  //           rotation: state.rotation,
  //           objects: state.data,
  //         );
  //       },
  //     ),
  //   );
  // }
}
