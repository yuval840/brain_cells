import 'package:brain_cells/constants.dart';
import 'package:flutter/material.dart';

class RoundedLogoutButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;

  const RoundedLogoutButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryLightColor,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //foregroundColor: kPrimaryColor,
              backgroundColor: color,
              textStyle: const TextStyle(fontSize: 18)),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
