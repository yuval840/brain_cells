import 'package:brain_cells/components/text_field_container.dart';
import 'package:brain_cells/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NameInputField extends StatelessWidget {
  final String hintText;
  //final IconData icon;
  final ValueChanged<String> onChanged;
  const NameInputField({
    Key? key,
    required this.hintText,
    //this.icon = Icons.person,
    required this.onChanged,
    required TextEditingController controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        //validator: (value) {
        //   if ((value == null || value.isEmpty) && this.hintText == 'Name') {
        //     Get.snackbar("Error", "please enter First Name",
        //         snackPosition: SnackPosition.BOTTOM,
        //         backgroundColor: Colors.red.withOpacity(0.1),
        //         colorText: Colors.red);
        //   } else if ((value == null || value.isEmpty) &&
        //       this.hintText == 'Last Name') {
        //     Get.snackbar("Error", "please enter Last Name",
        //         snackPosition: SnackPosition.BOTTOM,
        //         backgroundColor: Colors.red.withOpacity(0.1),
        //         colorText: Colors.red);
        //   }
        //   return null;
        // }

        onChanged: onChanged,
        decoration: InputDecoration(
          // icon: Icon(
          //   icon,
          //   color: kPrimaryColor,
          // ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
