import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saveme/model/user.dart';
import 'package:saveme/pages/authenticate.dart';
import 'package:saveme/services/sign_in.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    return user != null ? Authenticate() : SignIn();
  }
}
