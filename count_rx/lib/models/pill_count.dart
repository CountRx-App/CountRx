import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_model_utils.dart';

const kPillCountCollectionPath = "PillCount";
const kPillCountTitle = "title";
const kPillCountDescription = "description";
const kPillCountCount = "count";
const kPillCountTimestamp = "timestamp";
const kPillCountAuthorUid = "authorUid";

class PillCount {
  String? documentId;
  String title;
  String? desciption;
  int count = 0;
  DateTime timestamp;
  String authorUid;

  PillCount({
    this.documentId,
    required this.title,
    this.desciption,
    required this.count,
    required this.timestamp,
    required this.authorUid,
  }) {
    timestamp ??= DateTime.now();
  }

  set setCount(int count) {
    this.count = count;
  }

  PillCount.from(DocumentSnapshot doc)
      : this(
            documentId: doc.id,
            authorUid:
                FirestoreModelUtils.getStringField(doc, kPillCountAuthorUid),
            title: FirestoreModelUtils.getStringField(doc, kPillCountTitle),
            desciption:
                FirestoreModelUtils.getStringField(doc, kPillCountDescription),
            count: FirestoreModelUtils.getIntField(doc, kPillCountCount),
            timestamp:
                FirestoreModelUtils.getDateTimeField(doc, kPillCountTimestamp));

  Map<String, Object?> toMap() => {
        kPillCountTitle: title,
        kPillCountDescription: desciption,
        kPillCountCount: count,
        kPillCountTimestamp: timestamp,
        kPillCountAuthorUid: authorUid,
      };
}
