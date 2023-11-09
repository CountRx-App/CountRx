import 'dart:async';
import 'dart:io';

import 'package:count_rx/models/pill_count.dart';
import 'package:flutter/material.dart';

import '../components/flexible_button.dart';
import '../managers/pill_count_document_manager.dart';

class EditPage extends StatefulWidget {
  final String documentId;
  // final String imagePath;
  // final void Function(String, DateTime, String?) onSubmit;
  // final void Function() onCancel;

  const EditPage(
    this.documentId, {
    super.key,

    // required this.imagePath,
    // required this.onSubmit,
    // required this.onCancel,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleTextController = TextEditingController();
  StreamSubscription? _pillCountSubscription;
  PillCount? pc;

  @override
  void initState() {
    _pillCountSubscription = PillCountDocumentManager.instance.startListening(
      documentId: widget.documentId,
      observer: () {
        print("Got pill count!");

        if (PillCountDocumentManager.instance.hasAuthorUid) {
          setState(() {});
        }
        setState(() {});
      },
    );
    pc = PillCountDocumentManager.instance.latestPillCount;
    super.initState();
  }

  @override
  void dispose() {
    titleTextController.dispose();
    PillCountDocumentManager.instance.stopListening(_pillCountSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              PillCountDocumentManager.instance.delete();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.network(
            pc!.imageUrl,
            height: 400,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: titleTextController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: TextEditingController(
                text: PillCountDocumentManager
                    .instance.latestPillCount!.timestamp
                    .toString()),
            decoration: const InputDecoration(
              labelText: 'Timestamp',
              border: UnderlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlexibleButton(
                buttonText: 'Save and Close',
                onClick: () {},
              ),
              const SizedBox(height: 15),
              FlexibleButton(
                hollowButton: true,
                buttonText: 'Cancel',
                onClick: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
