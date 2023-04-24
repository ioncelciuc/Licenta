import 'package:flutter/material.dart';
import 'package:flutter_app/screens/browse_archetypes/browse_archetypes_screen.dart';
import 'package:flutter_app/screens/browse_cards/browse_cards_screen.dart';
import 'package:flutter_app/utils/card_list_type.dart';
import 'package:flutter_app/utils/card_search_delegate.dart';

class BrowseDatabaseScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> homeScaffoldState;

  const BrowseDatabaseScreen({
    super.key,
    required this.homeScaffoldState,
  });

  @override
  State<BrowseDatabaseScreen> createState() => _BrowseDatabaseScreenState();
}

class _BrowseDatabaseScreenState extends State<BrowseDatabaseScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int currentIndex = 0;

  final List<Tab> tabs = const [
    Tab(text: 'All Cards'),
    Tab(text: 'Banlist'),
    Tab(text: 'Archetypes'),
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            widget.homeScaffoldState.currentState!.openDrawer();
          },
        ),
        title: const Text('Database'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: tabs,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              CardListType? cardListType;
              if (tabController.index == 0) {
                cardListType = CardListType.ALL_CARDS;
              }
              if (tabController.index == 1) {
                cardListType = CardListType.BANLIST_CARDS;
              }
              showSearch(
                context: context,
                delegate: CardSearchDelegate(
                  listType: cardListType,
                ),
              );
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          BrowseCardsScreen(cardListType: CardListType.ALL_CARDS),
          BrowseCardsScreen(cardListType: CardListType.BANLIST_CARDS),
          BrowseArchetypesScreen()
        ],
      ),
    );
  }
}
