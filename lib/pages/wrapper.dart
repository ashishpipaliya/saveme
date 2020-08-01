import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saveme/enterance/signup/signup_screen.dart';
import 'package:saveme/model/user.dart';
import 'package:saveme/pages/authenticate.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user == null ? SignUpScreen() : Authenticate();
  }
}
