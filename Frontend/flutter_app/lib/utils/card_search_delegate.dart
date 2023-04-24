import 'package:flutter/material.dart';
import 'package:flutter_app/screens/browse_archetypes/browse_archetypes_screen.dart';
import 'package:flutter_app/screens/browse_cards/browse_cards_screen.dart';
import 'package:flutter_app/utils/card_list_type.dart';

class CardSearchDelegate extends SearchDelegate<String> {
  CardListType? listType;
  CardSearchDelegate({
    this.listType,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for the app bar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  // TODO: SHOW LAST SEARCHES
  @override
  Widget buildSuggestions(BuildContext context) {
    //show last 5 searches
    return ListView(
      children: [],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //show result based on the selection
    return listType == null
        ? BrowseArchetypesScreen(
            searchParams: query,
          )
        : BrowseCardsScreen(
            cardListType: listType!,
            searchParams: query,
          );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }
}
