import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_object_detection/learning_object_detection.dart';

class PillCounter {
  ObjectDetector detector = ObjectDetector(enableClassification: false);

  Future<int> count({required InputImage image}) async {
    List<DetectedObject> detectedObjects = await detector.detect(image);

    return Future<int>(() async {
      return detectedObjects.length;
    });
  }
}
