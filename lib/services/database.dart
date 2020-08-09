import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DatabaseService extends ChangeNotifier {
  final String uid, docId;
  DatabaseService({this.docId, this.uid});

  var data;
  var lastEdit = DateFormat('MMM d yyyy, h:mm aa').format(DateTime.now());

  Future addNote(String title, String description, String color) async {
    DocumentReference docRef = Firestore.instance.collection(uid).document();
    await docRef.setData({
      "title": title,
      "description": description,
      "lastEdit": lastEdit,
      "docId": docRef.documentID,
      "bgColor": "0xFFffffff"
    });
  }

  readNote() async {
    CollectionReference colRef = Firestore.instance.collection(uid);
    colRef.snapshots().listen((snapshots) {
      data = snapshots.documents;
    });
  }

  Future deleteNote(docId) async {
    CollectionReference colRef = Firestore.instance.collection(uid);
    await colRef.document(docId).delete();
  }

  Future updateNote(uid, docId, String title, String description) async {
    CollectionReference colRef = Firestore.instance.collection(uid);
    await colRef.document(docId).updateData(
        {"title": title, "description": description, "lastEdit": lastEdit});
  }

  Future updateColor(docId, String color) async {
    CollectionReference colRef = Firestore.instance.collection(uid);
    if (docId != null) {
      await colRef.document(docId).updateData({"bgColor": color});
    }
  }
}
