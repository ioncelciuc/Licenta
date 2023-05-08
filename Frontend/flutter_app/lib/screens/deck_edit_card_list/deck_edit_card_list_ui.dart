import 'package:flutter/material.dart';
import 'package:flutter_app/components/card_list_tile.dart';
import 'package:flutter_app/components/custom_text_field.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/utils/hive_helper.dart';

class DeckEditCardListUi extends StatefulWidget {
  const DeckEditCardListUi({super.key});

  @override
  State<DeckEditCardListUi> createState() => _DeckEditCardListUiState();
}

class _DeckEditCardListUiState extends State<DeckEditCardListUi> {
  TextEditingController queryController = TextEditingController();

  List<YuGiOhCard> allCards = HiveHelper.getCards();

  List<YuGiOhCard> searchedCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add cards to deck'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    textEditingController: queryController,
                    hintText: 'Search Card',
                  ),
                ),
                const SizedBox(width: 16),
                CircleAvatar(
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                    ),
                    onPressed: () {
                      setState(() {
                        searchedCards = allCards
                            .where((element) =>
                                element.name!.toLowerCase().contains(
                                    queryController.text.toLowerCase()) ||
                                element.desc!.toLowerCase().contains(
                                    queryController.text.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedCards.length,
              itemBuilder: (context, index) => CardListTile(
                card: searchedCards[index],
                isFromEditDeck: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
