import 'package:flutter/material.dart';
import 'package:flutter_app/screens/calculator/calculator_ui.dart';

class CalculatorScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> homeScaffoldState;

  const CalculatorScreen({
    super.key,
    required this.homeScaffoldState,
  });

  @override
  Widget build(BuildContext context) {
    return CalculatorUi(homeScaffoldState: homeScaffoldState);
  }
}
