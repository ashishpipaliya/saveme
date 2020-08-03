import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:saveme/pages/note/single_note.dart';
import 'package:saveme/pages/note/view_note.dart';
import 'package:saveme/services/auth.dart';

class HomePage extends StatelessWidget {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          IconButton(
            icon: Icon(AntDesign.logout),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: SingleNote(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewNote(),
              ));
        },
        label: Text("Add"),
        backgroundColor: Colors.yellow.shade400,
        icon: Icon(Icons.add),
      ),
    );
  }
}
