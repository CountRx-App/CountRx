import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_rx/models/pill_count.dart';

import 'auth_manager.dart';

class PillCountCollectionManager {
  List<PillCount> latestPillCounts = [];

  final CollectionReference _ref;

  static final instance = PillCountCollectionManager._privateConstructor();
  PillCountCollectionManager._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection(kPillCountCollectionPath);

  // Query<PillCount> get allPillCountQuery =>
  //     _ref.orderBy(kPillCountTimestamp, descending: true).withConverter(
  //           fromFirestore: (snapshot, _) => PillCount.from(snapshot),
  //           toFirestore: (pc, _) => pc.toMap(),
  //         );

  Query<PillCount> get myPillCountQuery => _ref
      .orderBy(kPillCountTimestamp, descending: true)
      .withConverter(
        fromFirestore: (snapshot, _) => PillCount.from(snapshot),
        toFirestore: (pc, _) => pc.toMap(),
      )
      .where(kPillCountAuthorUid, isEqualTo: AuthManager.instance.uid);

  void add({
    required String title,
    required String description,
    required int count,
    required DateTime timestamp,
  }) {
    _ref.add({
      kPillCountTitle: title,
      kPillCountDescription: description,
      kPillCountCount: count,
      kPillCountTimestamp: timestamp,
      kPillCountAuthorUid: AuthManager.instance.uid,
    }).then((docId) {
      print("Finished adding a document that now has id $docId");
    }).catchError((error) {
      print("There was an error adding the document $error");
    });
  }
}
