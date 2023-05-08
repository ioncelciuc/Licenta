import 'package:flutter/material.dart';
import 'package:flutter_app/components/image_display.dart';
import 'package:flutter_app/models/yugioh_card.dart';

class CardMainInfoUi extends StatelessWidget {
  final YuGiOhCard card;

  const CardMainInfoUi({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    String generalInfo = (card.type!.contains('Spell')
        ? 'SPELL / ${card.race}'
        : (card.type!.contains('Trap')
            ? 'TRAP / ${card.race}'
            : card.type!.contains('Skill')
                ? 'SKILL / ${card.race!}'
                : '${card.attribute!.toUpperCase()} / ${card.race} / ${(card.type!.contains('Monster') ? card.type!.substring(0, card.type!.lastIndexOf('Monster')) : card.type)}'));
    String stats = (card.attribute == null
        ? ''
        : (card.type!.contains('Link')
            ? '${card.atk} / LINK-${card.linkval}'
            : (card.type!.contains('Pendulum')
                ? '${card.atk} / ${card.def} / LEVEL ${card.level} / SCALE ${card.scale}'
                : '${card.atk} / ${card.def} / LEVEL ${card.level}')));

    return Scaffold(
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  ImageDisplay(
                    key: UniqueKey(),
                    cardId: card.cardId.toString(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    card.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(generalInfo),
                  stats.isNotEmpty ? const SizedBox(height: 8) : Container(),
                  stats.isNotEmpty ? Text(stats) : Container(),
                  const SizedBox(height: 8),
                  Text('${card.cardId}'),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(card.desc!),
            ),
          ),
        ],
      ),
    );
  }
}
