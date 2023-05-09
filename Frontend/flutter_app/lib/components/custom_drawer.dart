import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_drawer_header.dart';
import 'package:flutter_app/utils/app_router.dart';
import 'package:flutter_app/utils/shared_prefs_helper.dart';
import 'package:flutter_app/utils/token_helper.dart';

class CustomDrawer extends StatefulWidget {
  final List<Widget> drawerMainOptions;
  const CustomDrawer({
    super.key,
    required this.drawerMainOptions,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            const CustomDrawerHeader(),
            Column(children: widget.drawerMainOptions),
            const Divider(
              thickness: 1,
            ),
            TokenHelper.tokenExistsAndIsValid()
                ? ListTile(
                    leading: const Icon(Icons.card_travel),
                    title: const Text('Decks'),
                    onTap: () {
                      AppRouter.openDecksPage(context);
                    },
                  )
                : const SizedBox(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                AppRouter.openSettingsPage(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                AppRouter.openAboutPage(context);
              },
            ),
            TokenHelper.tokenExistsAndIsValid()
                ? ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () async {
                      SharedPrefsHelper.instance.setAuthToken('');
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
