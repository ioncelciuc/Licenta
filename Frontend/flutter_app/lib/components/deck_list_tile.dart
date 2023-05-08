import 'package:flutter/material.dart';
import 'package:flutter_app/models/deck.dart';
import 'package:flutter_app/utils/app_router.dart';

class DeckListTile extends StatelessWidget {
  final Deck deck;
  final bool isEditable;

  const DeckListTile({
    super.key,
    required this.deck,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          AppRouter.openDeckEditPage(context, deck, isEditable);
        },
        child: ListTile(
          enableFeedback: true,
          title: Text(
            deck.name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Main: ${deck.mainDeckCount}   Extra: ${deck.extraDeckCount}   Side: ${deck.sideDeckCount}',
              ),
            ],
          ),
          trailing: deck.mainDeckCount! >= 40
              ? const SizedBox()
              : const Tooltip(
                  message:
                      'Deck will be available for public only if main deck is at least 40 cards',
                  triggerMode: TooltipTriggerMode.tap,
                  showDuration: Duration(seconds: 8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.info,
                    size: 28,
                    color: Colors.red,
                  ),
                ),
        ),
      ),
    );
  }
}
