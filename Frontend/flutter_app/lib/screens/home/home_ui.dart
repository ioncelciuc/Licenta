import 'package:flutter/material.dart';
import 'package:flutter_app/models/drawer_item.dart';
import 'package:flutter_app/screens/browse_database/browse_database_screen.dart';

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
    DrawerItem('Decks', const Icon(Icons.card_travel)),
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
        //DASHBOARD
        return BrowseDatabaseScreen(homeScaffoldState: homeScaffoldState);
      case 1:
        // return DatabasePage(homeScaffoldState);
        return BrowseDatabaseScreen(homeScaffoldState: homeScaffoldState);
      case 2:
        // return FavoritesPage(homeScaffoldState);
        return Scaffold();
      case 3:
        // return CalculatorPage(homeScaffoldState);
        return Scaffold();
      case 4:
        // return DecksPage(homeScaffoldState);
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
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('test'),
              accountEmail: null,
            ),
            Column(children: drawerMainOptions),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Routers.showSettingsPage(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                // Navigator.of(context).pop();
                // await FirebaseHelper.logOut();
                // Routers.showLoginPage(context);
              },
            ),
          ],
        ),
      ),
      body: getDrawerPage(selectedDrawerIndex, homeScaffoldState),
    );
  }
}
