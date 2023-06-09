import 'package:flutter/material.dart';
import 'package:flutter_app/components/card_list_tile.dart';
import 'package:flutter_app/models/card_set.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/models/yugioh_card_set.dart';
import 'package:flutter_app/utils/hive_helper.dart';

class CardSetList extends StatelessWidget {
  final YuGiOhCardSet cardSet;

  const CardSetList({
    super.key,
    required this.cardSet,
  });

  @override
  Widget build(BuildContext context) {
    CardSet set = HiveHelper.getCardSet(cardSet.setName!);
    List<YuGiOhCard> cards = HiveHelper.getCardsFromSet(set.setName!);
    return Scaffold(
      appBar: AppBar(
        title: Text(set.setName!),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Set code: ${set.setCode}'),
                      set.numOfCards == null
                          ? Container()
                          : Text('Number of cards: ${set.numOfCards}'),
                      set.tcgDate == null
                          ? Container()
                          : Text('TCG date: ${set.tcgDate}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cards.length,
              itemBuilder: (context, index) => CardListTile(card: cards[index]),
            ),
          ),
        ],
      ),
    );
  }
}
