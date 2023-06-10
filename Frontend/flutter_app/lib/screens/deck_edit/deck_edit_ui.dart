import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_button.dart';
import 'package:flutter_app/components/image_display.dart';
import 'package:flutter_app/components/snackbar_handler.dart';
import 'package:flutter_app/cubit/deck_edit_cubit.dart';
import 'package:flutter_app/cubit/decks_cubit.dart';
import 'package:flutter_app/models/deck.dart';
import 'package:flutter_app/models/deck_card.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/screens/card_details/card_details_screen.dart';
import 'package:flutter_app/screens/deck_edit_card_list/deck_edit_card_list_ui.dart';
import 'package:flutter_app/utils/app_router.dart';
import 'package:flutter_app/utils/hive_helper.dart';
import 'package:flutter_app/utils/image_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckEditUi extends StatefulWidget {
  final Deck deck;
  final bool isEditable;

  const DeckEditUi({
    super.key,
    required this.deck,
    required this.isEditable,
  });

  @override
  State<DeckEditUi> createState() => _DeckEditUiState();
}

class _DeckEditUiState extends State<DeckEditUi> {
  List<DeckCard> deckCards = [];
  List<YuGiOhCard> main = [];
  List<YuGiOhCard> extra = [];
  List<YuGiOhCard> side = [];
  List<YuGiOhCard> cards = HiveHelper.getCards();

  buildList() {
    main = [];
    extra = [];
    side = [];
    deckCards = BlocProvider.of<DeckEditCubit>(context).deckCards;
    for (DeckCard deckCard in deckCards) {
      if (deckCard.place == 0) {
        main.add(cards.firstWhere(
            (element) => element.cardId.toString() == deckCard.cardId));
      } else if (deckCard.place == 1) {
        extra.add(cards.firstWhere(
            (element) => element.cardId.toString() == deckCard.cardId));
      } else {
        side.add(cards.firstWhere(
            (element) => element.cardId.toString() == deckCard.cardId));
      }
    }
  }

  int sortComparator(YuGiOhCard a, YuGiOhCard b) {
    if (a.type!.contains('Monster') && !b.type!.contains('Monster')) {
      return -1;
    }
    if (!a.type!.contains('Monster') && b.type!.contains('Monster')) {
      return 1;
    }
    if (a.type!.contains('Spell') && !b.type!.contains('Spell')) {
      return -1;
    }
    if (!a.type!.contains('Spell') && b.type!.contains('Spell')) {
      return 1;
    }
    if (a.type!.contains('Monster') && b.type!.contains('Monster')) {
      if (a.level != null && b.level == null) {
        return -1;
      }
      if (a.level == null && b.level != null) {
        return 1;
      }
      if (a.level != null && b.level != null) {
        if (a.level! > b.level!) {
          return -1;
        }
        if (a.level! < b.level!) {
          return 1;
        }
      }
    }
    return a.name!.compareTo(b.name!);
  }

  saveDeck() {
    if (main.length > 60) {
      SnackbarHandler(
        context: context,
        isError: true,
        message: 'Main deck should have a maximum of 60 cards.',
      );
      return;
    }
    if (extra.length > 15) {
      SnackbarHandler(
        context: context,
        isError: true,
        message: 'Extra deck should have maximum 15 cards',
      );
      return;
    }
    if (side.length > 15) {
      SnackbarHandler(
        context: context,
        isError: true,
        message: 'Side deck should have maximum 15 cards',
      );
      return;
    }
    BlocProvider.of<DeckEditCubit>(context).saveDeck();
  }

  @override
  Widget build(BuildContext context) {
    buildList();
    main.sort(sortComparator);
    extra.sort(sortComparator);
    side.sort(sortComparator);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (!widget.isEditable) {
              Navigator.of(context).pop();
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are you sure you want to exit?'),
                  content: const Text('Make sure you save first'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Exit'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        title: Text(widget.deck.name!),
        centerTitle: true,
        actions: [
          main.length < 40 || main.length > 60
              ? Container()
              : IconButton(
                  onPressed: () {
                    AppRouter.openStartingHandPage(context, main);
                  },
                  icon: const Icon(Icons.shuffle_rounded),
                ),
          !widget.isEditable
              ? Container()
              : IconButton(
                  onPressed: () {
                    saveDeck();
                  },
                  icon: const Icon(Icons.save),
                ),
          !widget.isEditable
              ? Container()
              : IconButton(
                  onPressed: () {
                    deleteDeckAndContents(context);
                  },
                  icon: const Icon(Icons.delete),
                ),
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                'Main Deck (${main.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 168 / 246,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: main.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => CardDetailsScreen(
                          card: main[index],
                          isDeckEdit: widget.isEditable,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: ImageDisplay(
                    key: UniqueKey(),
                    cardId: main[index].cardId.toString(),
                    imageType: ImageType.CARD_SMALL,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                'Extra Deck (${extra.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 168 / 246,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: extra.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => CardDetailsScreen(
                          card: extra[index],
                          isDeckEdit: widget.isEditable,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: ImageDisplay(
                    key: UniqueKey(),
                    cardId: extra[index].cardId.toString(),
                    imageType: ImageType.CARD_SMALL,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                'Side Deck (${side.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 168 / 246,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: side.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => CardDetailsScreen(
                          card: side[index],
                          isDeckEdit: widget.isEditable,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: ImageDisplay(
                    key: UniqueKey(),
                    cardId: side[index].cardId.toString(),
                    imageType: ImageType.CARD_SMALL,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: !widget.isEditable
          ? null
          : FloatingActionButton(
              onPressed: () async {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => const DeckEditCardListUi(),
                  ),
                )
                    .then((value) {
                  setState(() {});
                });
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  deleteDeckAndContents(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Are you sure you want to delete this deck?',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: 'Delete',
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      BlocProvider.of<DecksCubit>(context)
                          .deleteDeck(widget.deck);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    title: 'Cancel',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
