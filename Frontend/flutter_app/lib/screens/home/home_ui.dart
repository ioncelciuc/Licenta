import 'package:flutter/material.dart';
import 'package:flutter_app/components/image_display.dart';
import 'package:flutter_app/models/drawer_item.dart';
import 'package:flutter_app/screens/browse_database/browse_database_screen.dart';
import 'package:flutter_app/screens/browse_favourites/browse_favourites_screen.dart';
import 'package:flutter_app/utils/image_type.dart';

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
        return BrowseDatabaseScreen(
          homeScaffoldState: homeScaffoldState,
        );
      case 1:
        return BrowseDatabaseScreen(
          homeScaffoldState: homeScaffoldState,
        );
      case 2:
        return BrowseFavouritesScreen(
          homeScaffoldState: homeScaffoldState,
        );
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
      drawer: SizedBox(
        width: 300,
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: [
              Container(
                height: 300,
                width: 300,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 300,
                      child: ImageDisplay(
                        cardId: '95440946',
                        imageType: ImageType.ARTWORK,
                      ),
                    ),
                    // SizedBox(height: 32),
                    // Text(
                    //   'ioncelciuc',
                    //   style: TextStyle(fontSize: 20),
                    // ),
                  ],
                ),
              ),
              Column(children: drawerMainOptions),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
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
      ),
      body: getDrawerPage(selectedDrawerIndex, homeScaffoldState),
    );
  }
}
