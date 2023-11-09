import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_rx/models/pill_count.dart';

import 'auth_manager.dart';

class PillCountCollectionManager {
  List<PillCount> latestPillCounts = [];

  final CollectionReference _ref;

  static final instance = PillCountCollectionManager._privateConstructor();
  PillCountCollectionManager._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection(kPillCountCollectionPath);

  Query<PillCount> get myPillCountQuery => _ref
      .where(kPillCountAuthorUid, isEqualTo: AuthManager.instance.uid)
      .orderBy(kPillCountTimestamp, descending: true)
      .withConverter(
        fromFirestore: (snapshot, _) => PillCount.from(snapshot),
        toFirestore: (pc, _) => pc.toMap(),
      );

  void add({
    required String name,
    required int count,
    required DateTime timestamp,
    required String imageUrl,
    required String authorUid,
  }) {
    _ref.add({
      kPillCountName: name,
      kPillCountCount: count,
      kPillCountTimestamp: timestamp,
      kPillCountAuthorUid: authorUid,
      kPillCountImageUrl: imageUrl,
    }).then((docId) {
      print("Finished adding a document that now has id $docId");
    }).catchError((error) {
      print("There was an error adding the document $error");
    });
  }
}
