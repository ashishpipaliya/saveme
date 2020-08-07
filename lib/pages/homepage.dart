import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:saveme/shared/page_route.dart';
import 'package:saveme/pages/note/all_notes.dart';
import 'package:saveme/pages/note/view_note.dart';
import 'package:saveme/services/auth.dart';
import 'package:saveme/shared/appbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   titleSpacing: 1.0,
      //   title: Text(
      //     "Save Me",
      //     style: TextStyle(
      //       color: Colors.black54,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         AntDesign.user,
      //         color: Colors.grey,
      //       ),
      //       onPressed: () async {
      //         // await _auth.signOut();
      //       },
      //     )
      //   ],
      // ),
      appBar: CustomAppBar(
        title: "Save Me",
      ),
      body: AllNotes(),

      floatingActionButton: FloatingActionButton(
        tooltip: "Add note",
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
