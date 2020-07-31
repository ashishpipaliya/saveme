import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saveme/enterance/components/already_have_an_account_check.dart';
import 'package:saveme/enterance/components/rounded_button.dart';
import 'package:saveme/enterance/components/rounded_input_field.dart';
import 'package:saveme/enterance/components/rounded_password_field.dart';
import 'package:saveme/enterance/signup/components/bottom.dart';
import 'package:saveme/enterance/signup/components/divider.dart';
import 'package:saveme/enterance/welcome/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        child: SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("SIGNUP", style: TextStyle(fontWeight: FontWeight.bold)),
        SvgPicture.asset(
          "assets/icons/signup.svg",
          height: size.height * 0.30,
        ),
        RoundedInputField(
          hintText: "Enter Email",
          onChanged: (value) {},
        ),
        RoundedPasswordField(
          onChanged: (value) {},
        ),
        RoundedButton(
          text: "SIGNUP",
          press: () {},
        ),
        SizedBox(height: size.height * 0.03),
        AlreadyHaveAnAccountCheck(
          login: false,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Container();
                },
              ),
            );
          },
        ),
        OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocialIcon(
              iconSrc: "assets/icons/facebook.svg",
              press: () {},
            ),
            SocialIcon(
              iconSrc: "assets/icons/twitter.svg",
              press: () {},
            ),
            SocialIcon(
              iconSrc: "assets/icons/google-plus.svg",
              press: () {},
            ),
          ],
        ),
      ]),
    ));
  }
}
