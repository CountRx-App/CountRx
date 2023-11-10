import 'dart:async';

import 'package:count_rx/components/flexible_button.dart';
import 'package:count_rx/managers/pill_count_document_manager.dart';
import 'package:count_rx/models/pill_count.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String documentId;

  const EditPage(
    this.documentId, {
    super.key,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final titleController = TextEditingController();
  final countController = TextEditingController();
  StreamSubscription? _pillCountSubscription;
  late PillCount pc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _pillCountSubscription = PillCountDocumentManager.instance.startListening(
      documentId: widget.documentId,
      observer: () {
        setState(() {});
      },
    );
    pc = PillCountDocumentManager.instance.latestPillCount!;
    titleController.text = pc.name;
    countController.text = pc.count.toString();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Image.network(
              pc.imageUrl,
              height: 400,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a title";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: countController,
              decoration: const InputDecoration(
                labelText: 'Count',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.tryParse(value) == null) {
                  return "Please enter a number";
                } else if (int.parse(value) < 0) {
                  return "Please enter a positive number";
                }
                return null;
              },
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
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      PillCountDocumentManager.instance.update(
                        name: titleController.text,
                        count: int.parse(countController.text),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("An error occurred"),
                        ),
                      );
                    }
                    Navigator.of(context).pop();
                  },
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
      ),
    );
  }
}
