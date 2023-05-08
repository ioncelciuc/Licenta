import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/card_list_tile.dart';
import 'package:flutter_app/models/yugioh_card.dart';

class StartingHandUi extends StatefulWidget {
  final List<YuGiOhCard> main;

  const StartingHandUi({
    super.key,
    required this.main,
  });

  @override
  State<StartingHandUi> createState() => _StartingHandUiState();
}

class _StartingHandUiState extends State<StartingHandUi> {
  List<Widget> randomCards = [];

  buildRandomCards() {
    List<YuGiOhCard> startingHand = widget.main..shuffle(Random());
    startingHand = startingHand.take(5).toList();
    List<Widget> widgets = [];
    for (YuGiOhCard card in startingHand) {
      widgets.add(
        CardListTile(card: card),
      );
    }
    return widgets;
  }

  @override
  void initState() {
    randomCards = buildRandomCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starting hand'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                randomCards = buildRandomCards();
              });
            },
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      body: ListView(
        children: randomCards,
      ),
    );
  }
}
