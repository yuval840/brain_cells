import 'package:brain_cells/Screens/Login/components/background.dart';
<<<<<<< Updated upstream
=======
import 'package:brain_cells/Screens/Profile/profile_page_screen.dart';
import 'package:brain_cells/Screens/Signup/signup_screen.dart';
>>>>>>> Stashed changes
import 'package:brain_cells/components/already_have_an_account_check.dart';
import 'package:brain_cells/components/rounded_input_field.dart';
import 'package:brain_cells/components/text_field_container.dart';
import 'package:brain_cells/constants.dart';
import 'package:brain_cells/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
<<<<<<< Updated upstream

=======
import 'package:brain_cells/Screens/Signup/signup_screen.dart';
import 'package:brain_cells/Screens/Profile/profile_page_screen.dart';
>>>>>>> Stashed changes
import '../../../components/rounded_password_field.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
<<<<<<< Updated upstream
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset(
            "assets/icons/1(1).svg",
            height: size.height * 0.35,
          ),
          RoundedInputField(
            hintText: "Email address",
            onChanged: (value) {},
            key: null,
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          AlreadyHaveAnAccountCheck(
            press: () {},
          ),
        ],
=======
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/braincaell-logo2.svg",
              height: size.height * 0.4,
            ),
            SizedBox(
              height: size.height * 0.001,
            ),
            RoundedInputField(
              hintText: "Email address",
              onChanged: (value) {},
              key: null,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePageScreen();
                    },
                  ),
                );
              },
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
>>>>>>> Stashed changes
      ),
    );
  }
}
