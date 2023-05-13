import 'package:flutter/material.dart';
import 'package:flutter_app/components/card_list_tile.dart';
import 'package:flutter_app/models/translation.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/utils/card_list_type.dart';
import 'package:flutter_app/utils/hive_helper.dart';

class BrowseCardsUi extends StatelessWidget {
  final String? searchParams;
  final CardListType cardListType;

  const BrowseCardsUi({
    super.key,
    required this.cardListType,
    this.searchParams,
  });

  List<YuGiOhCard> getCards(CardListType cardListType, String? searchParams) {
    late List<YuGiOhCard> yugiohCards;
    switch (cardListType) {
      case CardListType.ALL_CARDS:
        yugiohCards = HiveHelper.getCards();
        break;
      case CardListType.EDIT_DECK_CARDS:
        yugiohCards = HiveHelper.getCards();
        break;
      case CardListType.BANLIST_CARDS:
        yugiohCards = HiveHelper.getBannedCards();
        break;
      case CardListType.FAVOURITE_CARDS:
        yugiohCards = HiveHelper.getFavourites();
        break;
      case CardListType.ARCHETYPE_CARDS:
        yugiohCards = HiveHelper.getArchetypeCards(searchParams!);
        break;
    }
    if (searchParams != null && searchParams.isNotEmpty) {
      // if (cardListType == CardListType.ARCHETYPE_CARDS) {
      //   //handle archetype search
      // }
      yugiohCards = yugiohCards
          .where((element) =>
              element.name!
                  .toLowerCase()
                  .contains(searchParams.toLowerCase()) ||
              element.desc!.toLowerCase().contains(searchParams.toLowerCase()))
          .toList();

      if (cardListType == CardListType.ALL_CARDS ||
          cardListType == CardListType.EDIT_DECK_CARDS) {
        List<Translation> translations =
            HiveHelper.getCardsByTranslationNameOrId(searchParams);
        for (Translation translation in translations) {
          YuGiOhCard cardAlreadyInList = yugiohCards.firstWhere(
            (element) => element.cardId == translation.cardId,
            orElse: () => YuGiOhCard(),
          );
          if (cardAlreadyInList.cardId == null) {
            yugiohCards.add(HiveHelper.getCardById(translation.cardId!));
          }
        }
      }
    }
    return yugiohCards;
  }

  @override
  Widget build(BuildContext context) {
    List<YuGiOhCard> cards = getCards(cardListType, searchParams);
    return Scaffold(
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) => CardListTile(
          card: cards[index],
          isFromEditDeck: cardListType == CardListType.EDIT_DECK_CARDS,
        ),
      ),
    );
  }
}
