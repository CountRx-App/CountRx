import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_model_utils.dart';

const kPillCountCollectionPath = "PillCount";
const kPillCountName = "name";
const kPillCountCount = "count";
const kPillCountTimestamp = "timestamp";
const kPillCountAuthorUid = "authorUid";

class PillCount {
  String? documentId;
  String name;
  int count;
  DateTime timestamp;
  String authorUid;

  PillCount({
    this.documentId,
    this.name = "",
    required this.count,
    required this.timestamp,
    required this.authorUid,
  }) {
    timestamp = DateTime.now();
  }

  set setCount(int count) {
    this.count = count;
  }

  PillCount.from(DocumentSnapshot doc)
      : this(
            documentId: doc.id,
            authorUid:
                FirestoreModelUtils.getStringField(doc, kPillCountAuthorUid),
            name: FirestoreModelUtils.getStringField(doc, kPillCountName),
            count: FirestoreModelUtils.getIntField(doc, kPillCountCount),
            timestamp:
                FirestoreModelUtils.getDateTimeField(doc, kPillCountTimestamp));

  Map<String, Object?> toMap() => {
        kPillCountName: name,
        kPillCountCount: count,
        kPillCountTimestamp: timestamp,
        kPillCountAuthorUid: authorUid,
      };
}
