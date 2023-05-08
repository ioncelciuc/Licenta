import 'package:flutter/material.dart';
import 'package:flutter_app/screens/dashboard/dashboard_ui.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> homeScaffoldState;

  const DashboardScreen({
    super.key,
    required this.homeScaffoldState,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardUi(homeScaffoldState: homeScaffoldState);
  }
}
