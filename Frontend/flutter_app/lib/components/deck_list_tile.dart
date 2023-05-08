import 'package:flutter/material.dart';
import 'package:flutter_app/models/deck.dart';
import 'package:flutter_app/utils/app_router.dart';

class DeckListTile extends StatelessWidget {
  final Deck deck;

  const DeckListTile({
    super.key,
    required this.deck,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          AppRouter.openDeckEditPage(context, deck);
        },
        child: ListTile(
          enableFeedback: true,
          title: Text(
            deck.name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Main: ${deck.mainDeckCount}   Extra: ${deck.extraDeckCount}   Side: ${deck.sideDeckCount}',
          ),
        ),
      ),
    );
  }
}
