import 'dart:ui';

import 'package:brain_cells/Screens/Profile/components/background.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return background(
      //new Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "דף פרופיל",
                style: TextStyle(fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Image.asset(
                "assets/images/male.png",
                height: size.height * 0.3,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "שם:",
                style: TextStyle(fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "שם משפחה:",
                style: TextStyle(fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "אימייל:",
                style: TextStyle(fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "ניקוד:",
                style: TextStyle(fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
