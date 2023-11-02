import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
      final XFile picture = await controller.takePicture();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(imagePath: picture.path),
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
}
