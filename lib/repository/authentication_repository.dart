import 'package:brain_cells/Screens/Dashbord/Dashbord_screen.dart';
import 'package:brain_cells/Screens/Signup/signup_screen.dart';
import 'package:brain_cells/Screens/Welcome/Welcome_screen.dart';
import 'package:brain_cells/Screens/profile/profile_page_screen.dart';
import 'package:brain_cells/repository/user_repository/exception/signup_email_pass_faild.dart';
import 'package:get/get.dart';
import 'package:brain_cells/components/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brain_cells/Screens/Dashbord/Dashbord_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomScreen())
        : Get.offAll(() => const ProfilePageScreen());
  }

  //FUNC
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const DashbordScreen())
          : Get.offAll(() => const WelcomScreen());
    } on FirebaseAuthException catch (e) {
      final ex = signInWithEmailAndPasswordFailure.code(e.code);
      print("fire base auth EXCEPTION - ${ex.message}");
      throw ex.message;
    } catch (_) {
      const ex = signInWithEmailAndPasswordFailure();
      throw ex.message;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = signInWithEmailAndPasswordFailure.code(e.code);
      throw ex.message;
    } catch (_) {
      const ex = signInWithEmailAndPasswordFailure();
      throw ex.message;
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
