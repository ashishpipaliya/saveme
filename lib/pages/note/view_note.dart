import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saveme/shared/constants.dart';
import 'package:saveme/model/user_model.dart';
import 'package:saveme/services/database.dart';

class ViewNote extends StatefulWidget {
  final String title, description, lastEdit, docId;
  String color;
  ViewNote(
      {Key key,
      this.title,
      this.description,
      this.lastEdit,
      this.docId,
      this.color})
      : super(key: key);
  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  TextEditingController _title, _description;
  var lastEdit = DateFormat('MMM d yyyy, h:mm aa').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.title);
    _description = TextEditingController(text: widget.description);
  }

  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);
    DatabaseService dbService = DatabaseService(uid: "notes-${user.uid}");
    // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    Color color =
        widget.docId == null ? Colors.white : Color(int.parse(widget.color));

    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        actions: [
          IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () async {
                dbService.deleteNote(widget.docId);
                Navigator.pop(context);
              }),
          // IconButton(
          //   icon: Icon(Icons.update),
          //   onPressed: () {
          //     if (_title.text.isNotEmpty || _description.text.isNotEmpty) {
          //       if (widget.docId == null) {
          //         dbService.addNote(
          //             _title.text, _description.text, white.toString());
          //       } else {
          //         dbService.updateNote(
          //           "notes-${user.uid}",
          //           widget.docId,
          //           _title.text,
          //           _description.text,
          //         );
          //       }
          //       Navigator.pop(context);
          //     } else {
          //       Navigator.pop(context);
          //       return Fluttertoast.showToast(
          //           msg: "Empty note discarded",
          //           toastLength: Toast.LENGTH_SHORT,
          //           gravity: ToastGravity.BOTTOM,
          //           backgroundColor: Colors.black,
          //           textColor: Colors.white,
          //           timeInSecForIosWeb: 1,
          //           fontSize: 16.0);
          //     }
          //   },
          // ),
        ],
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (_title.text.isNotEmpty || _description.text.isNotEmpty) {
              if (widget.docId == null) {
                dbService.addNote(
                  _title.text,
                  _description.text,
                  widget.color,
                );
              } else {
                dbService.updateNote("notes-${user.uid}", widget.docId,
                    _title.text, _description.text);
              }
            } else {
              return Fluttertoast.showToast(
                  msg: "Empty note discarded",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0);
            }
            return true;
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            padding: EdgeInsets.all(5.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _title,
                    maxLines: null,
                    cursorColor: Colors.black54,
                    decoration: inputDecoration.copyWith(hintText: "Title"),
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: size.height * 0.50,
                    child: TextField(
                      controller: _description,
                      maxLines: null,
                      cursorColor: Colors.black54,
                      decoration: inputDecoration.copyWith(hintText: "Note"),
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(icon: Icon(Icons.add_box), onPressed: () {}),
            Text("Last Edit ${widget.lastEdit ?? lastEdit} "),
            SizedBox(
              height: size.height * 0.040,
              width: size.width * 0.50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ColorButton(
                    color: lightBlue,
                    onPressed: () {
                      setState(() {
                        dbService.updateColor(widget.docId, lightBlueC);
                      });
                    },
                  ),
                  ColorButton(
                    color: lightBrown,
                    onPressed: () {
                      setState(() {
                        dbService.updateColor(widget.docId, lightBrownC);
                      });
                    },
                  ),
                  ColorButton(
                    color: lightCyan,
                    onPressed: () {
                      setState(() {
                        dbService.updateColor(widget.docId, lightCyanC);
                      });
                    },
                  ),
                  ColorButton(
                    color: lightGreen,
                    onPressed: () {
                      setState(() {
                        dbService.updateColor(widget.docId, lightGreenC);
                      });
                    },
                  ),
                  ColorButton(
                    color: lightGrey,
                    onPressed: () {
                      setState(() {
                        dbService.updateColor(widget.docId, lightGreyC);
                      });
                    },
                  ),
                  ColorButton(
                    color: lightOrange,
                    onPressed: () {
                      setState(() {
                        dbService.updateColor(widget.docId, lightOrangeC);
                      });
                    },
                  ),
                  ColorButton(
                    color: lightRed,
                    onPressed: () {
                      setState(() {
                        dbService.updateColor(widget.docId, lightRedC);
                      });
                    },
                  ),
                  ColorButton(
                    color: white,
                    onPressed: () {
                      setState(() {
                        dbService.updateColor(widget.docId, whiteC);
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

const inputDecoration = InputDecoration(border: InputBorder.none);

class ColorButton extends StatelessWidget {
  Color color;
  Function onPressed;

  ColorButton({this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color,
        foregroundColor: color,
      ),
    );
  }
}
