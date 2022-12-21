import 'package:brain_cells/Screens/Login/login_screen.dart';
import 'package:brain_cells/Screens/Signup/compunents/background.dart';
import 'package:brain_cells/Screens/Signup/compunents/or_divider.dart';
import 'package:brain_cells/Screens/Signup/compunents/social_icon.dart';
import 'package:brain_cells/components/already_have_an_account_check.dart';
import 'package:brain_cells/components/rounded_button.dart';
import 'package:brain_cells/components/rounded_input_field.dart';
import 'package:brain_cells/components/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brain_cells/components/name_input_field';

class Body extends StatelessWidget {
  final Widget child;

  const Body({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            SvgPicture.asset(
              "assets/icons/1(1).svg",
              height: size.height * 0.3,
            ),
            SizedBox(height: size.height * 0.02),
            NameInputField(
              hintText: 'Name',
              onChanged: (value) {},
            ),
            NameInputField(
              hintText: 'Last Name',
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Email Adrress",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            SizedBox(height: size.height * 0.01),
            RoundedButton(
              text: "Sing Up",
              press: () {},
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
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
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
