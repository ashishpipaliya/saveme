import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:saveme/pages/note/view_note.dart';

class SingleNote extends StatefulWidget {
  @override
  _SingleNoteState createState() => _SingleNoteState();
}

class _SingleNoteState extends State<SingleNote> {
  var data;
  @override
  void initState() {
    super.initState();
    readNote();
  }

  readNote() async {
    var user = await FirebaseAuth.instance.currentUser();
    CollectionReference colRef =
        Firestore.instance.collection("notes-${user.uid}");
    colRef.snapshots().listen((snapshots) {
      setState(() {
        data = snapshots.documents;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Container()
        : StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: data.length ?? 0,
            itemBuilder: (context, index) {
              var title = data[index]["title"];
              var description = data[index]["description"];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewNote(
                      title: title,
                      description: description,
                    ),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          description,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(2, index.isEven ? 1.5 : 1);
            },
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 2.0,
          );
  }
}
