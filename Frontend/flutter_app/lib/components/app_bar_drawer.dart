import 'package:flutter/material.dart';

class AppBarDrawer extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> homeScaffoldState;
  final List<Widget>? actions;

  AppBarDrawer({
    super.key,
    required this.title,
    required this.homeScaffoldState,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          homeScaffoldState.currentState!.openDrawer();
        },
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
