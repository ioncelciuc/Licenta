import 'package:flutter/material.dart';
import 'package:flutter_app/components/image_display.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/utils/app_router.dart';
import 'package:flutter_app/utils/image_type.dart';

class CardListTile extends StatelessWidget {
  final YuGiOhCard card;
  final bool isFromEditDeck;

  const CardListTile({
    super.key,
    required this.card,
    this.isFromEditDeck = false,
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
    return Card(
      margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
      elevation: 5,
      child: InkWell(
        onTap: () {
          AppRouter.openCardDetailsPage(
            context,
            card,
            isDeckEdit: isFromEditDeck,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                imageBuilder(),
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(generalInfo),
                      Text(stats),
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

  Row imageBuilder() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ImageDisplay(
              key: UniqueKey(),
              cardId: card.cardId.toString(),
              banlist:
                  card.banlistInfo != null ? card.banlistInfo!.banTcg : null,
              imageType: ImageType.CARD_SMALL,
            ),
            card.banlistInfo != null
                ? card.banlistInfo!.banTcg == 'Banned'
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.block,
                          color: Colors.red,
                        ),
                      )
                    : card.banlistInfo!.banTcg == 'Limited'
                        ? Container(
                            color: Colors.black,
                            child: const Icon(
                              Icons.looks_one,
                              color: Colors.red,
                            ),
                          )
                        : card.banlistInfo!.banTcg == 'Semi-Limited'
                            ? Container(
                                color: Colors.black,
                                child: const Icon(
                                  Icons.looks_two,
                                  color: Colors.red,
                                ),
                              )
                            : Container()
                : Container()
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
