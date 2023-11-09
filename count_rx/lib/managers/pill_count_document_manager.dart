import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_rx/models/pill_count.dart';
import 'package:flutter/material.dart';

class PillCountDocumentManager {
  PillCount? latestPillCount;
  final CollectionReference _ref;

  static final instance = PillCountDocumentManager._privateConstructor();
  PillCountDocumentManager._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection(kPillCountCollectionPath);

  StreamSubscription startListening({
    required String documentId,
    required Function observer,
  }) {
    return _ref.doc(documentId).snapshots().listen(
        (DocumentSnapshot documentSnapshot) {
      latestPillCount = PillCount.from(documentSnapshot);
      observer();
    }, onError: (error) {
      print("Error getting the document $error");
    });

    // return _ref.snapshots().listen((QuerySnapshot querySnapshot) {
    //   latestMovieQuotes =
    //       querySnapshot.docs.map((doc) => MovieQuote.from(doc)).toList();
    //   observer();
    // }, onError: (error) {
    //   debugPrint("Error listening $error");
    // });
  }

  void stopListening(StreamSubscription? subscription) {
    subscription?.cancel();
  }

  void update({required String title, required String description}) {
    _ref.doc(latestPillCount!.documentId!).update({
      kPillCountTitle: title,
      kPillCountDescription: description,
      kPillCountTimestamp: Timestamp.now(),
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

  String get title => latestPillCount?.title ?? "";
  String get description => latestPillCount?.desciption ?? "";
}
