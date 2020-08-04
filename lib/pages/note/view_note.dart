import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saveme/model/user_model.dart';
import 'package:saveme/services/database.dart';

class ViewNote extends StatefulWidget {
  final String title, description, lastEdit, docId;
  const ViewNote(
      {Key key, this.title, this.description, this.lastEdit, this.docId})
      : super(key: key);
  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  TextEditingController _title, _description;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.title);
    _description = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService dbService = DatabaseService(uid: "notes-${user.uid}");

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () async {
                dbService.deleteNote("notes-${user.uid}", widget.docId);
                Navigator.pop(context);
              }),
          IconButton(
            icon: Icon(Icons.update),
            onPressed: () {
              if (_title.text.isNotEmpty || _description.text.isNotEmpty) {
                if (widget.docId == null) {
                  dbService.addNote(_title.text, _description.text);
                } else {
                  dbService.updateNote("notes-${user.uid}", widget.docId,
                      _title.text, _description.text);
                }
              } else {
                print("enter inputs");
              }
              Navigator.pop(context);
            },
          ),
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
            Text("Last Edit ${widget.lastEdit}"),
            IconButton(icon: Icon(Icons.menu), onPressed: () {})
          ],
        ),
      ),
    );
  }
}

const inputDecoration = InputDecoration(border: InputBorder.none);
