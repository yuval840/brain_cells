import 'package:brain_cells/Screens/Dashbord/Dashbord_screen.dart';
import 'package:brain_cells/Screens/Signup/signup_screen.dart';
import 'package:brain_cells/Screens/Welcome/Welcome_screen.dart';
import 'package:brain_cells/Screens/profile/profile_page_screen.dart';
import 'package:brain_cells/components/user_model.dart';
import 'package:brain_cells/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/authentication_repository.dart';
import 'package:brain_cells/repository/user_repository/exception/signup_email_pass_faild.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final Name = TextEditingController();
  final Lname = TextEditingController();

  final userRepo = Get.put(UserRepository());
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    Get.to(() => const DashbordScreen());
  }
}
//}
