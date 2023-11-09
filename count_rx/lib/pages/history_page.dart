import 'package:count_rx/components/pill_count_row.dart';
import 'package:count_rx/managers/pill_count_collection_manager.dart';
import 'package:count_rx/models/pill_count.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pill Count History"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FirestoreListView<PillCount>(
        query: PillCountCollectionManager.instance.myPillCountQuery,
        itemBuilder: (context, doc) {
          PillCount pc = doc.data();
          return PillCountRow(
            pillCount: pc,
            onTapCallback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditPage(pc.documentId!);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
