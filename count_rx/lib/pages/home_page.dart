import 'package:learning_input_image/learning_input_image.dart';
import 'package:count_rx/components/home_page_drawer.dart';
import 'package:flutter/material.dart';

import 'camera_page.dart';

class HomePage extends StatefulWidget {
  final String currentUser;
  final List<CameraDescription>? cameras;

  const HomePage({
    super.key,
    required this.currentUser,
    required this.cameras,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Text(
                "Welcome ${widget.currentUser}",
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("History"),
              leading: const Icon(Icons.history_edu),
              trailing: const Icon(Icons.menu),
              onTap: () {
                // TODO: Open history page, when implemented
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Most Recent"),
              leading: const Icon(Icons.history),
              trailing: const Icon(Icons.menu),
              onTap: () {
                // TODO: Open "most recent" detail page, when implemented
              },
            ),
          ),
        ],
      ),
      drawer: HomePageDrawer(),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraPage(cameras: widget.cameras),
              ),
            );
          },
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}
