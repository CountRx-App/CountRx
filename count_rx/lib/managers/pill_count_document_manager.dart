import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_rx/managers/auth_manager.dart';
import 'package:count_rx/models/pill_count.dart';

class PillCountDocumentManager {
  PillCount? latestPillCount;
  final CollectionReference _ref;

  static final instance = PillCountDocumentManager._privateConstructor();
  PillCountDocumentManager._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection(kPillCountCollectionPath);

  StreamSubscription startListening({
    required String documentId,
    required void Function() observer,
  }) {
    return _ref.doc(documentId).snapshots().listen(
      (DocumentSnapshot documentSnapshot) {
        latestPillCount = PillCount.from(documentSnapshot);
        print(latestPillCount.toString());
        observer();
      },
      onError: (error) {
        print("Error getting the document $error");
      },
    );
  }

  Query<PillCount> get latestPillCountQuery => _ref
      .where(kPillCountAuthorUid, isEqualTo: AuthManager.instance.uid)
      .orderBy(kPillCountTimestamp, descending: true)
      .limitToLast(1)
      .withConverter(
        fromFirestore: (snapshot, _) => PillCount.from(snapshot),
        toFirestore: (pc, _) => pc.toMap(),
      );

  void stopListening(StreamSubscription? subscription) {
    subscription?.cancel();
  }

  void update({required String name, required int count}) {
    _ref.doc(latestPillCount!.documentId!).update({
      kPillCountName: name,
      kPillCountCount: count,
    }).then((_) {
      print("Finished updating the document");
    }).catchError((error) {
      print("There was an error adding the document $error");
    });
  }

  void delete() {
    _ref.doc(latestPillCount!.documentId!).delete();
  }

  void clearLatest() {
    latestPillCount = null;
  }

  bool get hasAuthorUid =>
      latestPillCount != null && latestPillCount!.authorUid.isNotEmpty;
  String get authorUid => latestPillCount?.authorUid ?? "";

  String get name => latestPillCount?.name ?? "";
}
