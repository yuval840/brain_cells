import 'dart:ui';
import 'package:brain_cells/Screens/Dashbord/Dashbord_screen.dart';
import 'package:brain_cells/Screens/profile/components/background.dart';
import 'package:brain_cells/components/user_model.dart';
import 'package:brain_cells/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiver/strings.dart';
import '../../../components/rounded_button.dart';
import '../../../controllers/profile_controller.dart';
import '../../../controllers/sign_up_controller.dart';
import '../../../repository/authentication_repository.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = Get.put(profileController());
    return Background(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
                future: controller.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          const Text(
                            "דף פרופיל",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                            width: size.width * 1,
                          ),
                          Image.asset(
                            "assets/images/male.png",
                            height: size.height * 0.3,
                          ),
                          Text(
                            "Hello " + userData.Lname + " " + userData.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            userData.email,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          // Text(
                          //   "אימייל:",
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          //   textDirection: TextDirection.rtl,
                          // ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            "Score: ${userData.Score}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            //textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            height: size.height * 0.20,
                          ),
                          RoundedButton(
                              text: "Games",
                              press: () {
                                Get.offAll(() => const DashbordScreen());
                                return DashbordScreen();
                              }),
                          RoundedButton(
                              text: "logout",
                              press: () {
                                AuthenticationRepository.instance.logout();
                              }),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(
                        child: Text("Somthing went Worng."),
                      );
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            //child: Column
          ),
        ],
      ),
    );
  }
}
