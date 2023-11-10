import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_model_utils.dart';

const kPillCountCollectionPath = "PillCount";
const kPillCountName = "name";
const kPillCountCount = "count";
const kPillCountTimestamp = "timestamp";
const kPillCountAuthorUid = "authorUid";
const kPillCountImageUrl = "imageUrl";

class PillCount {
  String? documentId;
  String authorUid;
  int count;
  String imageUrl;
  String name;
  DateTime timestamp;

  PillCount({
    this.documentId,
    this.name = "",
    required this.authorUid,
    required this.count,
    required this.imageUrl,
    required this.timestamp,
  });

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
              FirestoreModelUtils.getDateTimeField(doc, kPillCountTimestamp),
          imageUrl: FirestoreModelUtils.getStringField(doc, kPillCountImageUrl),
        );

  Map<String, Object?> toMap() => {
        kPillCountName: name,
        kPillCountCount: count,
        kPillCountTimestamp: timestamp,
        kPillCountAuthorUid: authorUid,
        kPillCountImageUrl: imageUrl,
      };

  @override
  String toString() {
    return "Title: $name, Count: $count";
  }
}
