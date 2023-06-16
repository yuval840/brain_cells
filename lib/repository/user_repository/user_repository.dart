import 'dart:ffi';

import 'package:brain_cells/components/user_model.dart';
import 'package:brain_cells/repository/user_repository/exception/signup_email_pass_faild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brain_cells/controllers/sign_up_controller.dart';

import '../authentication_repository.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    try {
      if (user.name.toString() == 'null') {
        final ex = signInWithEmailAndPasswordFailure.code('invalid-Name');
        throw ex.message;
      } else if (user.Lname.toString() == "null") {
        final ex = signInWithEmailAndPasswordFailure.code('invalid-Last-Name');
        throw ex.message;
      }
      await AuthenticationRepository.instance
          .createUserWithEmailAndPassword(user.email, user.Pass);
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
      throw error.toString();
    }

    await db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar("success", "your account has been created",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Somthing went worng. try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      //print(error.toString());
    });
  }

  LoginUser(String email, String pass) async {
    try {
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email, pass);
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
      throw error.toString();
    }
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUsers() async {
    final snapshot = await db.collection("Users").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }
}
