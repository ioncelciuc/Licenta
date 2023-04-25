import 'package:hive/hive.dart';

part 'favourite_card.g.dart';

@HiveType(typeId: 9)
class FavouriteCard {
  @HiveField(0)
  final int cardId;

  FavouriteCard(
    this.cardId,
  );
}
