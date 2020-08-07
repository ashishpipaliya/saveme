import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:saveme/services/auth.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double prefferedHeight = 60.0;

  String title;
  AuthService _auth = AuthService();
  CustomAppBar({this.title}) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: prefferedHeight,
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.dehaze),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Search Your Notes",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
                icon: Icon(AntDesign.user),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          actions: [
                            FlatButton.icon(
                                onPressed: () {
                                  _auth.signOut();
                                  Navigator.pop(context);
                                },
                                icon: Icon(AntDesign.logout),
                                label: Text("Log Out from this device")),
                          ],
                        );
                      });
                })
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(prefferedHeight);
}
