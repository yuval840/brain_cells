import 'package:brain_cells/Screens/Dashbord/Dashbord_screen.dart';
import 'package:brain_cells/Screens/Login/components/background.dart';
import 'package:brain_cells/Screens/Login/login_screen.dart';
import 'package:brain_cells/Screens/Signup/signup_screen.dart';
import 'package:brain_cells/Screens/Welcome/Welcome_screen.dart';
import 'package:brain_cells/components/already_have_an_account_check.dart';
import 'package:brain_cells/components/rounded_button.dart';
import 'package:brain_cells/components/rounded_input_field.dart';
import 'package:brain_cells/components/text_field_container.dart';
import 'package:brain_cells/constants.dart';
import 'package:brain_cells/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brain_cells/Screens/Signup/signup_screen.dart';
import 'package:brain_cells/Screens/Profile/profile_page_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../components/rounded_password_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:brain_cells/controllers/login_controller.dart';

import '../../../repository/authentication_repository.dart';
import '../../../repository/user_repository/user_repository.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final controller = Get.put(loginController());
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();
  final userRepo = Get.put(UserRepository());
  String error = '';
  String ValE = '';
  String ValP = '';

  bool active = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
              onChanged: (value) {
                ValE = value;
              },
              controller: controllerEmail,
            ),
            RoundedPasswordField(
              onChanged: (value) {
                ValP = value;
              },
              controller: controllerPass,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                loginController.instance.LoginUser(ValE, ValP);
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
      ),
    );
  }
}
