import 'package:flutter/material.dart';
import 'package:flutter_app/models/card_prices.dart';
import 'package:flutter_app/models/yugioh_card.dart';

class CardPricesUi extends StatelessWidget {
  final YuGiOhCard card;

  const CardPricesUi({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    card.cardPrices ??= CardPrices();
    return Scaffold(
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/cardmarket.png',
                    width: 200,
                    height: 50,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 8),
                      child: Text(
                        '${card.cardPrices!.cardmarketPrice}\$',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/tcgplayer.jpg',
                    width: 200,
                    height: 50,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 8),
                      child: Text(
                        '${card.cardPrices!.tcgplayerPrice}\$',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/amazon.png',
                    width: 200,
                    height: 50,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 8),
                      child: Text(
                        '${card.cardPrices!.amazonPrice}\$',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/ebay.png',
                    width: 200,
                    height: 50,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 8),
                      child: Text(
                        '${card.cardPrices!.ebayPrice}\$',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/coolstuffinc.png',
                    width: 200,
                    height: 50,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 8),
                      child: Text(
                        '${card.cardPrices!.coolstuffincPrice}\$',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
