import 'package:flutter/material.dart';
import 'package:flutter_app/screens/browse_cards/browse_cards_ui.dart';
import 'package:flutter_app/utils/card_list_type.dart';

class BrowseCardsScreen extends StatelessWidget {
  final String? searchParams;
  final CardListType cardListType;
  const BrowseCardsScreen({
    super.key,
    this.searchParams,
    this.cardListType = CardListType.ALL_CARDS,
  });

  @override
  Widget build(BuildContext context) {
    return BrowseCardsUi(
      cardListType: cardListType,
      searchParams: searchParams,
    );
  }
}
