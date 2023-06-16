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

class loginController extends GetxController {
  static loginController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  Future<void> LoginUser(String email, String pass) async {
    await _userRepo.LoginUser(email, pass);
    Get.to(() => const DashbordScreen());
  }

//get User Email and pass to UserRepository to fetch user record
  getUserDataLog() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      return null;
    }
  }
}
