import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar_drawer.dart';

class CalculatorUi extends StatelessWidget {
  final GlobalKey<ScaffoldState> homeScaffoldState;

  const CalculatorUi({
    super.key,
    required this.homeScaffoldState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDrawer(
        title: 'Calculator',
        homeScaffoldState: homeScaffoldState,
      ),
    );
  }
}
