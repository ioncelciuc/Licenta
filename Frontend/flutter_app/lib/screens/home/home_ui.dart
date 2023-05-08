import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_drawer.dart';
import 'package:flutter_app/models/drawer_item.dart';
import 'package:flutter_app/screens/browse_database/browse_database_screen.dart';
import 'package:flutter_app/screens/browse_favourites/browse_favourites_screen.dart';
import 'package:flutter_app/screens/dashboard/dashboard_screen.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  int selectedDrawerIndex = 0;

  final drawerItems = [
    DrawerItem('Dashboard', const Icon(Icons.dashboard)),
    DrawerItem('Database', const Icon(Icons.list_alt)),
    DrawerItem('Favourites', const Icon(Icons.favorite)),
    DrawerItem('Calculator', const Icon(Icons.calculate)),
  ];

  selectDrawerPage(int index) {
    if (selectedDrawerIndex == index) {
      Navigator.of(context).pop();
    } else {
      setState(() => selectedDrawerIndex = index);
      Navigator.of(context).pop();
    }
  }

  getDrawerPage(int pos, GlobalKey<ScaffoldState> homeScaffoldState) {
    switch (pos) {
      case 0:
        return DashboardScreen(homeScaffoldState: homeScaffoldState);
      case 1:
        return BrowseDatabaseScreen(homeScaffoldState: homeScaffoldState);
      case 2:
        return BrowseFavouritesScreen(homeScaffoldState: homeScaffoldState);
      case 3:
        // return CalculatorPage(homeScaffoldState);
        return Scaffold();
    }
  }

  @override
  Widget build(BuildContext context) {
    var drawerMainOptions = <Widget>[];
    for (int i = 0; i < drawerItems.length; i++) {
      drawerMainOptions.add(ListTile(
        leading: drawerItems[i].icon,
        title: Text(drawerItems[i].title),
        selected: i == selectedDrawerIndex,
        onTap: () => selectDrawerPage(i),
      ));
    }

    GlobalKey<ScaffoldState> homeScaffoldState = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: homeScaffoldState,
      drawer: CustomDrawer(drawerMainOptions: drawerMainOptions),
      body: getDrawerPage(selectedDrawerIndex, homeScaffoldState),
    );
  }
}
