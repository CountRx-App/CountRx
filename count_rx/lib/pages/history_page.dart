import 'package:count_rx/components/pill_count_row.dart';
import 'package:count_rx/managers/pill_count_collection_manager.dart';
import 'package:count_rx/models/pill_count.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

import '../managers/auth_manager.dart';
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
        actions: AuthManager.instance.isSignedIn
            ? null
            : [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginFrontPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.login),
                )
              ],
      ),
      body: FirestoreListView<PillCount>(
        query: PillCountCollectionManager.instance.allPillCountsQuery,
        itemBuilder: (context, snapshot) {
          // Data is now typed!  The data is already a MovieQuote
          PillCount cr = snapshot.data();
          return PillCountRow(
            pillCount: cr,
            onTapCallback: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return EditPage(cr.documentId!);
                }),
              );
            },
          );
        },
      ),
    );
  }
}
