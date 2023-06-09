import 'package:flutter/material.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/screens/card_details/card_set_list.dart';

class CardSetsUi extends StatelessWidget {
  final YuGiOhCard card;

  const CardSetsUi({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: card.cardSets!.length,
        itemBuilder: (context, index) {
          String subtitle =
              '${card.cardSets![index].setCode}   (${card.cardSets![index].setRarity})   \$${card.cardSets![index].setPrice}';
          return Card(
            elevation: 8,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CardSetList(
                      cardSet: card.cardSets![index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.cardSets![index].setName ?? 'Unknown set',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
