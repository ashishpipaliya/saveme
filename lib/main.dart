import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saveme/constants.dart';
import 'package:saveme/model/user.dart';
import 'package:saveme/pages/wrapper.dart';
import 'package:saveme/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        // home: Wrapper(),
        home: Wrapper(),
      ),
    );
  }
}
