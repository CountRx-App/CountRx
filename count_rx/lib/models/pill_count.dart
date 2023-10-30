const kPillCountCollectionPath = "PillCount";
const kPillCountCount = "count";
const kPillCountName = "name";
const kPillCountTimestamp = "timestamp";

class PillCount {
  String? documentId;
  int count = 0;
  String name;
  DateTime? timestamp;

  PillCount({
    this.documentId,
    required this.count,
    this.name = "",
    this.timestamp,
  }) {
    timestamp ??= DateTime.now();
  }

  set setCount(int count) {
    this.count = count;
  }
}
