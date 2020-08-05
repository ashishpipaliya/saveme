import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:saveme/page_route.dart';
import 'package:saveme/pages/note/single_note.dart';
import 'package:saveme/pages/note/view_note.dart';
import 'package:saveme/services/auth.dart';

class HomePage extends StatelessWidget {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 1.0,
        title: Text(
          "Save Me",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              AntDesign.logout,
              color: Colors.grey,
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: SingleNote(),
      floatingActionButton: FloatingActionButton(
        tooltip: "add note",
        child: Icon(
          AntDesign.plus,
          color: Colors.grey,
        ),
        onPressed: () {
          Navigator.push(context, FadeRoute(page: ViewNote()));
        },
      ),
    );
  }
}
