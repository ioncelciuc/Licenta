// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar_card_details.dart';
import 'package:flutter_app/cubit/deck_edit_cubit.dart';
import 'package:flutter_app/cubit/favourite_cubit.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/screens/card_details/card_main_info_ui.dart';
import 'package:flutter_app/screens/card_details/card_prices_ui.dart';
import 'package:flutter_app/utils/hive_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardDetailsScreen extends StatefulWidget {
  final YuGiOhCard card;
  final bool isDeckEdit;

  const CardDetailsScreen({
    super.key,
    required this.card,
    required this.isDeckEdit,
  });

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;
  int index = 0;
  late bool isFavourite;

  getCardDetailsPage(int index) {
    switch (index) {
      case 0:
        return CardMainInfoUi(card: widget.card);
      case 1:
        return CardPricesUi(card: widget.card);
      default:
        return CardMainInfoUi(card: widget.card);
    }
  }

  int maxAllowedNrOfCards() {
    if (widget.card.banlistInfo != null) {
      if (widget.card.banlistInfo!.banTcg != null) {
        if (widget.card.banlistInfo!.banTcg == "Limited") {
          return 1;
        } else if (widget.card.banlistInfo!.banTcg == "Banned") {
          return 0;
        } else if (widget.card.banlistInfo!.banTcg == "Semi-Limited") {
          return 2;
        }
      }
    }
    return 3;
  }

  @override
  void initState() {
    isFavourite = HiveHelper.isFavourite(widget.card.cardId!);
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBarCardDetails(
        title: widget.card.name!,
        tabController: tabController,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        actions: [
          IconButton(
            onPressed: () async {
              if (isFavourite) {
                await BlocProvider.of<FavouriteCubit>(context)
                    .deleteFavourite(widget.card.cardId!);
              } else {
                await BlocProvider.of<FavouriteCubit>(context)
                    .addFavourite(widget.card.cardId!);
              }
              setState(() {
                isFavourite = !isFavourite;
              });
              BlocProvider.of<FavouriteCubit>(context).emitFavouriteInitial();
            },
            icon: isFavourite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: getCardDetailsPage(index),
      bottomNavigationBar:
          !widget.isDeckEdit ? const SizedBox() : buildBottomNavBar(context),
    );
  }

  Container buildBottomNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      height: 58,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(50, 50),
              ),
              onPressed: BlocProvider.of<DeckEditCubit>(context)
                          .numberOfCardsInDeck(widget.card.cardId.toString()) >=
                      maxAllowedNrOfCards()
                  ? null
                  : () {
                      BlocProvider.of<DeckEditCubit>(context)
                          .addCardToMainDeckOrExtraDeck(
                        widget.card.cardId.toString(),
                        widget.card.type!,
                      );
                      setState(() {});
                    },
              child: Text(
                "+ Main (${BlocProvider.of<DeckEditCubit>(context).numberOfCardsInMainOrExtraDeck(widget.card.cardId.toString())})",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(50, 50),
              ),
              onPressed: BlocProvider.of<DeckEditCubit>(context)
                          .numberOfCardsInMainOrExtraDeck(
                              widget.card.cardId.toString()) ==
                      0
                  ? null
                  : () {
                      BlocProvider.of<DeckEditCubit>(context)
                          .removeCardFromMainDeckOrExtraDeck(
                              widget.card.cardId.toString());
                      setState(() {});
                    },
              child: const Text(
                "- Main",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(50, 50),
              ),
              onPressed: BlocProvider.of<DeckEditCubit>(context)
                          .numberOfCardsInDeck(widget.card.cardId.toString()) >=
                      maxAllowedNrOfCards()
                  ? null
                  : () {
                      BlocProvider.of<DeckEditCubit>(context)
                          .addCardToSideDeck(widget.card.cardId.toString());
                      setState(() {});
                    },
              child: Text(
                "+ Side (${BlocProvider.of<DeckEditCubit>(context).numberOfCardsInSideDeck(widget.card.cardId.toString())})",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(50, 50),
              ),
              onPressed: BlocProvider.of<DeckEditCubit>(context)
                          .numberOfCardsInSideDeck(
                              widget.card.cardId.toString()) ==
                      0
                  ? null
                  : () {
                      BlocProvider.of<DeckEditCubit>(context)
                          .removeCardFromSideDeck(
                              widget.card.cardId.toString());
                      setState(() {});
                    },
              child: const Text(
                "- Side",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
