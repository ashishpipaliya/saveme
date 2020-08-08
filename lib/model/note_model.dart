import 'package:flutter/cupertino.dart';
import 'package:saveme/shared/constants.dart';

class NoteModel extends ChangeNotifier {
  final String title, description, lastEdit, docId, bgColor;

  NoteModel(
      this.title, this.description, this.lastEdit, this.docId, this.bgColor);
}

// var title = data[index]["title"] ?? "";
// var description = data[index]["description"] ?? "";
// var lastEdit = data[index]["lastEdit"];
// var docId = data[index]["docId"];
// var bgColor = data[index]["bgColor"] ?? whiteC;
