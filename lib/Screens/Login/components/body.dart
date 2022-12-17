import 'package:brain_cells/Screens/Login/components/background.dart';
import 'package:brain_cells/components/already_have_an_account_check.dart';
import 'package:brain_cells/components/rounded_input_field.dart';
import 'package:brain_cells/components/text_field_container.dart';
import 'package:brain_cells/constants.dart';
import 'package:brain_cells/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/rounded_password_field.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
      ),
    );
  }
}
