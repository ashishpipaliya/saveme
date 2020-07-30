import 'package:flutter/material.dart';
import 'package:saveme/pages/note/single_note.dart';
import 'package:saveme/pages/note/view_note.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: Center(
        child: SingleNote(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewNote(
                  title: "",
                  description: "",
                ),
              ));
        },
        label: Text("Add"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
