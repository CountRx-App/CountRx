import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_rx/models/pill_count.dart';

class PillCountCollectionManager {
  List<PillCount> latestPillCounts = [];

  final CollectionReference _ref;

  static final instance = PillCountCollectionManager._privateConstructor();
  PillCountCollectionManager._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection(kPillCountCollectionPath);

  Query<PillCount>? myPillCountQuery() {
    // TODO: implement after auth manager is implemented

    // TODO: make return type non nullable after implementation
    return null;
  }
}
