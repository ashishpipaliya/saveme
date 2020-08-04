import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid, docId;
  DatabaseService({this.docId, this.uid});

  var data;
  var lastEdit = DateFormat('MMM d yyyy, h:mm aa').format(DateTime.now());

  Future addNote(String title, String description) async {
    DocumentReference docRef = Firestore.instance.collection(uid).document();
    await docRef.setData({
      "title": title,
      "description": description,
      "lastEdit": lastEdit,
      "docId": docRef.documentID
    });
  }

  readNote() async {
    CollectionReference colRef = Firestore.instance.collection(uid);
    colRef.snapshots().listen((snapshots) {
      data = snapshots.documents;
    });
  }

  Future deleteNote(uid, docId) async {
    CollectionReference colRef = Firestore.instance.collection(uid);
    await colRef.document(docId).delete();
  }

  Future updateNote(uid, docId, String title, String description) async {
    CollectionReference colRef = Firestore.instance.collection(uid);
    await colRef.document(docId).updateData(
        {"title": title, "description": description, "lastEdit": lastEdit});
  }
}
