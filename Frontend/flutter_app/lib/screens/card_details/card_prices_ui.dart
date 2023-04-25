import 'package:flutter/material.dart';
import 'package:flutter_app/models/card_prices.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:url_launcher/url_launcher.dart';

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
            child: InkWell(
              onTap: () {
                launchUrl(
                  Uri.parse(
                    'https://www.cardmarket.com/en/YuGiOh/Products/Singles?searchString=${card.name!}',
                  ),
                );
              },
              child: Container(
                height: 70,
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/cardmarket.png',
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: InkWell(
              onTap: () {
                launchUrl(
                  Uri.parse(
                    'https://www.tcgplayer.com/search/yugioh/product?productLineName=yugioh&q=${card.name!}&view=grid&ProductTypeName=Cards&page=1',
                  ),
                );
              },
              child: Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/tcgplayer.png',
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
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: InkWell(
              onTap: () {
                launchUrl(
                  Uri.parse(
                    'https://www.coolstuffinc.com/main_search.php?pa=searchOnName&page=1&resultsPerPage=25&q=${card.name!}&sh=1',
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                height: 70,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/coolstuffinc.png',
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
          ),
        ],
      ),
    );
  }
}
