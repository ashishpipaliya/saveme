import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  Future updateNote(String title, String description) async {
    CollectionReference colRef = Firestore.instance.collection(uid);
    await colRef
        .document()
        .setData({"title": title, "description": description});
  }

  var data;
  readNote() async {
    var user = await FirebaseAuth.instance.currentUser();
    CollectionReference colRef = Firestore.instance.collection(uid);
    colRef.snapshots().listen((snapshots) {
      return data = snapshots.documents;
    });
  }
}
