import 'package:flutter/material.dart';
import 'package:saveme/services/auth.dart';
import 'package:saveme/services/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RaisedButton.icon(
            color: Colors.red.shade100,
            icon: Icon(Icons.send),
            onPressed: () {
              _auth.signOut();
            },
            label: Text("Sign Out"),
          ),
        ),
      ),
    );
  }
}
