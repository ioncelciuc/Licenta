import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar_drawer.dart';
import 'package:flutter_app/screens/browse_cards/browse_cards_screen.dart';

class BrowseDatabaseScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> homeScaffoldState;

  const BrowseDatabaseScreen({
    super.key,
    required this.homeScaffoldState,
  });

  @override
  State<BrowseDatabaseScreen> createState() => _BrowseDatabaseScreenState();
}

class _BrowseDatabaseScreenState extends State<BrowseDatabaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDrawer(
        homeScaffoldState: widget.homeScaffoldState,
        title: 'Database',
      ),
      body: const BrowseCardsScreen(),
    );
  }
}
