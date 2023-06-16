import 'package:flutter/material.dart';
import 'package:brain_cells/components/user_model.dart';
import 'components/body.dart';
import '../Dashbord/components/body.dart';

class DashbordScreen extends StatelessWidget {
  const DashbordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
