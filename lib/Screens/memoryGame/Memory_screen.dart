import 'package:flutter/material.dart';
import 'package:brain_cells/Screens/memoryGame/components/body.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MemoryMatchGame(),
    );
  }
}
