import 'package:flutter/material.dart';
import 'package:flutter_app/components/card_list_tile.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/utils/hive_helper.dart';

class BrowseCardsUi extends StatelessWidget {
  const BrowseCardsUi({super.key});

  @override
  Widget build(BuildContext context) {
    List<YuGiOhCard> cards = HiveHelper.getCards();
    return Scaffold(
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) => CardListTile(card: cards[index]),
      ),
    );
  }
}
