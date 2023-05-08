import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar_drawer.dart';
import 'package:flutter_app/components/custom_button.dart';
import 'package:flutter_app/utils/deck_search_delegate.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardUi extends StatelessWidget {
  final GlobalKey<ScaffoldState> homeScaffoldState;

  const DashboardUi({
    super.key,
    required this.homeScaffoldState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDrawer(
        title: 'Dashboard',
        homeScaffoldState: homeScaffoldState,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: DeckSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        children: [
          const Text(
            'Welcome, Duelist!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          CustomButton(
            title: 'Download Game Rules',
            onPressed: () async {
              await launchUrl(
                Uri.parse(
                  'https://img.yugioh-card.com/en/downloads/rulebook/SD_RuleBook_EN_10.pdf',
                ),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          const SizedBox(height: 32),
          CustomButton(
            title: 'Download Begginer\'s Guide',
            onPressed: () async {
              await launchUrl(
                Uri.parse(
                  'https://img.yugioh-card.com/en/downloads/rulebook/YS17_BG_EN.pdf',
                ),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ],
      ),
    );
  }
}
