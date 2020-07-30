import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final String title, description;
  ViewNote({this.title, this.description});

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  TextEditingController _title, _description;

  CollectionReference colRef = Firestore.instance.collection("notes");

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.title);
    _description = TextEditingController(text: widget.description);
  }

  saveUpdate() {
    try {
      if (_title.text.isNotEmpty || _description.text.isNotEmpty) {
        colRef.add({"title": _title.text, "description": _description.text});
      }
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
  }

  deleteNote() {
    colRef.document().delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        saveUpdate();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  deleteNote();
                })
          ],
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            padding: EdgeInsets.all(5.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: _title,
                        maxLines: null,
                        decoration: inputDecoration.copyWith(hintText: "Title"),
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextField(
                        controller: _description,
                        maxLines: null,
                        decoration: inputDecoration.copyWith(hintText: "Note"),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.add_box), onPressed: () {}),
              Text("Edited ${DateTime.now()}"),
              IconButton(icon: Icon(Icons.menu), onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

const inputDecoration = InputDecoration(border: InputBorder.none);
