import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double prefferedHeight = 70.0;
  String title;

  CustomAppBar({this.title}) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: prefferedHeight,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500, width: 1.0),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(prefferedHeight);
}
