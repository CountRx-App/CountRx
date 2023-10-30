class PillCount {
  int count = 0;
  String name;
  final DateTime timestamp = DateTime.now();

  PillCount({
    required this.count,
    this.name = "",
  });

  set setCount(int count) {
    this.count = count;
  }
}
