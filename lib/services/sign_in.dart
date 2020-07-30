import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:saveme/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.blue.shade300),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.blue.shade100,
                  ),
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Enter an email' : null,
                        onChanged: (email_value) {
                          setState(() {
                            email = email_value;
                          });
                        },
                      ),
                      TextFormField(
                        validator: (value) => value.length < 6
                            ? 'Enter minimum 6 char. password'
                            : null,
                        onChanged: (password_value) {
                          setState(() {
                            password = password_value;
                          });
                        },
                        obscureText: true,
                      ),
                      Text(
                        error,
                        style: TextStyle(
                            fontSize: 13.0, color: Colors.red.shade400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic result = await _auth
                                    .signInWithEmailPass(email, password);

                                if (result == null) {
                                  setState(() {
                                    error = "Please enter a valid email";
                                  });
                                }
                              }
                            },
                            color: Colors.blue.shade200,
                            icon: Icon(AntDesign.login),
                            label: Text("Log In"),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RaisedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic result = await _auth
                                    .signUpWithEmailPass(email, password);

                                if (result == null) {
                                  setState(() {
                                    error = "Please enter a valid email";
                                  });
                                }
                              }
                            },
                            color: Colors.blue.shade200,
                            icon: Icon(AntDesign.user),
                            label: Text("Sign Up"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton.icon(
                onPressed: () async {},
                color: Colors.red.shade100,
                icon: Icon(AntDesign.google),
                label: Text("Sign In With Google"),
              ),

              // anonymoously
              RaisedButton.icon(
                onPressed: () async {
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    print("couldn't sign in");
                  } else {
                    print("signed in");
                  }
                },
                color: Colors.yellow.shade100,
                icon: Icon(AntDesign.user),
                label: Text("Sign In Anonymously"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
