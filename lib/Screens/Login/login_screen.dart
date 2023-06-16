import 'package:brain_cells/Screens/Login/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Body(),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String errorMessage = '';

//   Future<void> _login(BuildContext context) async {
//     final String email = _emailController.text.trim();
//     final String password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       setState(() {
//         errorMessage = 'Please enter email and password.';
//       });
//       return;
//     }

//     try {
//       final UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Perform successful login action (e.g., navigate to home screen)
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Login failed. Please check your credentials.';
//       });
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
