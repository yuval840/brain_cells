import 'package:brain_cells/Screens/Sudoku/sudoku_screen.dart';
import 'package:brain_cells/Screens/Welcome/Welcome_screen.dart';
import 'package:brain_cells/Screens/memoryGame/Memory_screen.dart';
import 'package:brain_cells/Screens/profile/profile_page_screen.dart';
import 'package:brain_cells/Screens/puzzle_game/Puzzle_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:brain_cells/Screens/Dashbord/components/background.dart';
import '../../../components/Rounded_Profile_button.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_logout_button.dart';
import '../../../constants.dart';
import '../../../repository/authentication_repository.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';
import '../Dashbord_screen.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //provide total hight and width of our screend
    return background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text(
              "Welcome To",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: size.height * 0.02),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SvgPicture.asset(
                "assets/icons/1(1).svg",
                height: size.height * 0.3,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            RoundedProfileButton(
              text: "Profile",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ProfilePageScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Sudoku",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SudokuScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Memory Game",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MemoryScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Puzzle Game",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const PuzzleGameScreen();
                    },
                  ),
                );
              },
            ),
            RoundedLogoutButton(
              text: "Logout",
              press: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const WelcomScreen();
                //     },
                //   ),
                AuthenticationRepository.instance.logout();
              },
            ),
            // RoundedButton(
            //   text: "SIGN UP",
            //   color: kPrimaryLightColor,
            //   textColor: Colors.black,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return SignUpScreen();
            //         },
            //      ),
            //    );
            //  },
            // ),
          ],
        ),
      ),
    );
  }
}
