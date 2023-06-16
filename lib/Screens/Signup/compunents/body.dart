import 'package:brain_cells/Screens/Login/login_screen.dart';
import 'package:brain_cells/Screens/Signup/compunents/background.dart';
import 'package:brain_cells/Screens/Signup/compunents/or_divider.dart';
import 'package:brain_cells/Screens/Signup/compunents/social_icon.dart';
import 'package:brain_cells/Screens/Signup/signup_screen.dart';
import 'package:brain_cells/components/already_have_an_account_check.dart';
import 'package:brain_cells/components/rounded_button.dart';
import 'package:brain_cells/components/rounded_input_field.dart';
import 'package:brain_cells/components/rounded_password_field.dart';
import 'package:brain_cells/components/user_model.dart';
import 'package:brain_cells/controllers/sign_up_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brain_cells/components/name_input_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:brain_cells/components/user_model.dart';
import 'package:brain_cells/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:brain_cells/controllers/sign_up_controller.dart';

class Body extends StatelessWidget {
  final Widget child;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> data = {'email': '', 'password': ''};
  Body({
    Key? key,
    required this.child,
  }) : super(key: key);

  bool _validateFields() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formKey,
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
                controller: controller.Name,
                hintText: 'Name',
                onChanged: (value) {
                  data['Name'] = value;
                },
              ),
              NameInputField(
                controller: controller.Lname,
                hintText: 'Last Name',
                onChanged: (value) {
                  data['Last Name'] = value;
                },
              ),
              RoundedInputField(
                controller: controller.email,
                hintText: "Email Adrress",
                onChanged: (value) {
                  data['email'] = value;
                },
              ),
              RoundedPasswordField(
                controller: controller.password,
                onChanged: (value) {
                  data['password'] = value;
                },
              ),
              SizedBox(height: size.height * 0.01),
              RoundedButton(
                text: "Sign Up",
                press: () {
                  // if (_formKey.currentState!.validate()) {
                  //   print("key not null");
                  //   print(data);
                  //   SignUpController.instance
                  //       .registerUser(data['email']!, data['password']!);
                  // }
                  if (_validateFields()) {
                    final user = UserModel(
                      name: data['Name'].toString(),
                      Lname: data['Last Name'].toString(),
                      email: data['email'].toString(),
                      Pass: data['password'].toString(),
                    );
                    SignUpController.instance.createUser(user);
                  }
                },
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
      ),
    );
  }
}
