import '../Sudoku/compunents/body.dart';
import 'package:flutter/material.dart';

class SudokuScreen extends StatelessWidget {
  const SudokuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
