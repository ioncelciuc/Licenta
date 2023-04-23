import 'package:flutter/material.dart';
import 'package:flutter_app/components/image_display.dart';
import 'package:flutter_app/models/yugioh_card.dart';

class CardListTile extends StatelessWidget {
  final YuGiOhCard card;
  const CardListTile({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
      elevation: 5,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                ImageDisplay(cardId: card.cardId.toString()),
                // CachedNetworkImage(
                //   imageUrl: card.cardImages![0].imageUrlSmall!,
                //   placeholder: (context, url) {
                //     return Image.asset('assets/card_back.png');
                //   },
                //   errorWidget: (context, url, error) {
                //     return Image.asset('assets/card_back.png');
                //   },
                // ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(card.type!),
                      Text(card.race!),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
