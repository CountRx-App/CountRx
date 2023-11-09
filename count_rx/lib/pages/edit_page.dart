import 'dart:io';

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
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime timestamp = DateTime.now();

  @override
  void initState() {
    PillCountDocumentManager.instance.clearLatest();

    PillCountDocumentManager.instance.startListening(
      documentId: widget.documentId,
      observer: () {
        print("Got pill count!");

        if (PillCountDocumentManager.instance.hasAuthorUid) {
          _userSubscription = UserDataDocumentManager.instance.startListening(
              documentId:
                  PillCountDocumentManager.instance.latestPillCount!.authorUid,
              observer: () {
                setState(() {});
              });
        }
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    titleTextController.dispose();
    descriptionTextController.dispose();
    PillCountDocumentManager.instance.stopListening(_pillCountSubscription);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.file(
            File(widget.imagePath),
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller:
                TextEditingController(text: timestamp.toLocal().toString()),
            decoration: const InputDecoration(
              labelText: 'Timestamp',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description (Optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlexibleButton(
                buttonText: 'Submit',
                onClickCallback: () {},
              ),
              // FlexibleButton(
              //   buttonText: 'Cancel',
              //   onClickCallback: () {},
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
