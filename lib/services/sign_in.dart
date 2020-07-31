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

  double loginOpacity = 1.0;
  double signupOpacity = 0.0;

  Color loginButtonColor = Colors.blue.shade200;
  Color signupButtonColor = Colors.blue.shade200;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () async {
                              setState(() {
                                loginOpacity = 1.0;
                                signupOpacity = 0.0;
                                loginButtonColor = Colors.blue.shade100;
                                signupButtonColor = Colors.blue.shade200;
                              });
                            },
                            color: loginButtonColor,
                            child: Text("Log In"),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              setState(() {
                                loginOpacity = 0.0;
                                signupOpacity = 1.0;
                                loginButtonColor = Colors.blue.shade200;
                                signupButtonColor = Colors.blue.shade100;
                              });
                            },
                            color: signupButtonColor,
                            child: Text("Sign Up"),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Stack(
                        children: [
                          Opacity(
                            opacity: loginOpacity,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: inpurDecoration.copyWith(
                                    // labelText: 'Email',
                                    hintText: "Email",
                                    prefixIcon: Icon(AntDesign.mail),
                                  ),
                                  validator: (value) =>
                                      value.isEmpty ? 'Enter an email' : null,
                                  onChanged: (emailValue) {
                                    setState(() {
                                      email = emailValue;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  decoration: inpurDecoration.copyWith(
                                    // labelText: 'Password',
                                    hintText: "Password",
                                    prefixIcon: Icon(AntDesign.lock1),
                                  ),
                                  validator: (value) => value.length < 6
                                      ? 'Enter minimum 6 char. password'
                                      : null,
                                  onChanged: (passwordValue) {
                                    setState(() {
                                      password = passwordValue;
                                    });
                                  },
                                  obscureText: true,
                                ),
                                Text(
                                  error,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.red.shade400),
                                ),
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
                              ],
                            ),
                          ),
                          Opacity(
                            opacity: signupOpacity,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: inpurDecoration.copyWith(
                                    // labelText: 'Email',
                                    hintText: "Email",
                                    prefixIcon: Icon(AntDesign.mail),
                                  ),
                                  validator: (value) =>
                                      value.isEmpty ? 'Enter an email' : null,
                                  onChanged: (emailValue) {
                                    setState(() {
                                      email = emailValue;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  decoration: inpurDecoration.copyWith(
                                    // labelText: 'Password',
                                    hintText: "Password",
                                    prefixIcon: Icon(AntDesign.lock1),
                                  ),
                                  validator: (value) => value.length < 6
                                      ? 'Enter minimum 6 char. password'
                                      : null,
                                  onChanged: (passwordValue) {
                                    setState(() {
                                      password = passwordValue;
                                    });
                                  },
                                  obscureText: true,
                                ),
                                Text(
                                  error,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.red.shade400),
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
                                  icon: Icon(AntDesign.login),
                                  label: Text("Sign up"),
                                ),
                              ],
                            ),
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

const InputDecoration inpurDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
