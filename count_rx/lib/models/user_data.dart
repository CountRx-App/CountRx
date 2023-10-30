class UserData {
  String? documentId;
  String displayName;
  String imageUrl;
  DateTime created;

  UserData({
    this.documentId,
    required this.displayName,
    required this.imageUrl,
    required this.created,
  });
}
