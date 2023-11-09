import 'package:count_rx/firebase_options.dart';
import 'package:count_rx/models/pill_counter.dart';
import 'package:count_rx/pages/home_page.dart';
import 'package:count_rx/pages/login_page.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_storage/firebase_ui_storage.dart';
import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';

PillCounter counter = PillCounter();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final List<CameraDescription> cameras = await availableCameras();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final storage = FirebaseStorage.instance;

  await FirebaseUIStorage.configure(
    FirebaseUIStorageConfiguration(
      storage: storage,
      uploadRoot: FirebaseStorage.instance.ref("Photos"),
      namingPolicy: const UuidFileUploadNamingPolicy(),
    ),
  );

  runApp(MyApp(
    cameras: cameras,
  ));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  static final _defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );

  const MyApp({
    super.key,
    required this.cameras,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) => MaterialApp(
        title: 'CountRx',
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        // home: HomePage(
        //   currentUser: "User",
        //   cameras: cameras, // Invalid constant value error
        // ),
        home: LoginPage(
          cameras: cameras,
        ),
      ),
    );
  }
}
