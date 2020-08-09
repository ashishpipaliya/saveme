import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saveme/enterance/components/rounded_button.dart';
import 'package:saveme/enterance/components/rounded_input_field.dart';
import 'package:saveme/enterance/components/rounded_password_field.dart';
import 'package:saveme/enterance/signup/components/bottom.dart';
import 'package:saveme/enterance/signup/components/divider.dart';
import 'package:saveme/enterance/signup/components/background.dart';
import 'package:saveme/services/auth.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        child: SingleChildScrollView(
      child: loading
          ? Container(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            )
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("GET INSIDE",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.30,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red.shade300),
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
                onChanged: (passwordValue) {
                  setState(() {
                    password = passwordValue;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(
                    text: "LOG IN",
                    press: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result =
                          await _auth.signInWithEmailPass(email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = "Something went wrong please try again";
                        });
                      }
                    },
                  ),
                  SizedBox(width: size.height * 0.03),
                  RoundedButton(
                    text: "SIGN UP",
                    press: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result =
                          await _auth.signUpWithEmailPass(email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = "Something went wrong please try again";
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Text("LOG IN if you already have an account otherwise SIGN UP",
                  style: TextStyle(fontSize: 12.0)),
              SizedBox(height: size.height * 0.02),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconSrc: "assets/icons/hacker.svg",
                    press: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInAnon();
                      if (result == null) {
                        setState(() {
                          loading = false;
                          print("couldn't sign in");
                        });
                      } else {
                        setState(() {
                          loading = false;
                        });
                        print("signed in");
                      }
                    },
                  ),
                  SocialIcon(
                    iconSrc: "assets/icons/google.svg",
                    press: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.googleSignIn();
                      if (result == null) {
                        setState(() {
                          loading = false;
                        });
                        // print("couldn't sign in");
                      } else {
                        setState(() {
                          loading = false;
                        });
                        // print("signed in using google");
                      }
                    },
                  ),
                ],
              ),
            ]),
    ));
  }
}
