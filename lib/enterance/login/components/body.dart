import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saveme/enterance/components/already_have_an_account_check.dart';
import 'package:saveme/enterance/components/rounded_button.dart';
import 'package:saveme/enterance/components/rounded_input_field.dart';
import 'package:saveme/enterance/components/rounded_password_field.dart';
import 'package:saveme/enterance/login/components/background.dart';
import 'package:saveme/enterance/signup/signup_screen.dart';
import 'package:saveme/services/auth.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email, password = "";
  bool loading = false;

  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: loading
            ? Container(
                child: Center(
                  child: CupertinoActivityIndicator(
                    radius: 30.0,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "SIGN IN",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.30,
                  ),
                  RoundedInputField(
                    hintText: "Enter Email",
                    onChanged: (emailValue) {
                      setState(() {
                        email = emailValue;
                      });
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (emailValue) {
                      setState(() {
                        password = emailValue;
                      });
                    },
                  ),
                  RoundedButton(
                    text: "LOG IN",
                    press: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result =
                          await _auth.signInWithEmailPass(email, password);
                      print(result);
                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  AlreadyHaveAnAccountCheck(press: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ));
                  })
                ],
              ),
      ),
    );
  }
}
