import 'package:flutter_app/models/banlist_info.dart';
import 'package:flutter_app/models/card_image.dart';
import 'package:flutter_app/models/card_prices.dart';
import 'package:flutter_app/models/yugioh_card_set.dart';
import 'package:hive/hive.dart';

part 'yugioh_card.g.dart';

@HiveType(typeId: 3)
class YuGiOhCard {
  @HiveField(0)
  String? id;

  @HiveField(1)
  int? cardId;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? type;

  @HiveField(4)
  String? desc;

  @HiveField(5)
  int? atk;

  @HiveField(6)
  int? def;

  @HiveField(7)
  int? level;

  @HiveField(8)
  String? race;

  @HiveField(9)
  String? attribute;

  @HiveField(10)
  String? archetype;

  @HiveField(11)
  int? scale;

  @HiveField(12)
  int? linkval;

  @HiveField(13)
  List<String>? linkmarkers;

  @HiveField(14)
  List<YuGiOhCardSet>? cardSets;

  @HiveField(15)
  List<CardImage>? cardImages;

  @HiveField(16)
  CardPrices? cardPrices;

  @HiveField(17)
  BanlistInfo? banlistInfo;

  YuGiOhCard({
    this.id,
    this.cardId,
    this.name,
    this.type,
    this.desc,
    this.atk,
    this.def,
    this.level,
    this.race,
    this.attribute,
    this.archetype,
    this.scale,
    this.linkval,
    this.linkmarkers,
    this.cardSets,
    this.cardImages,
    this.cardPrices,
    this.banlistInfo,
  });

  YuGiOhCard.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    cardId = json['id'];
    name = json['name'];
    type = json['type'];
    desc = json['desc'];
    if (json['atk'] != null) {
      atk = json['atk'];
    }
    if (json['def'] != null) {
      def = json['def'];
    }
    if (json['level'] != null) {
      level = json['level'];
    }
    if (json['race'] != null) {
      race = json['race'];
    }
    if (json['attribute'] != null) {
      attribute = json['attribute'];
    }
    if (json['archetype'] != null) {
      archetype = json['archetype'];
    }
    if (json['scale'] != null) {
      scale = json['scale'];
    }
    if (json['linkval'] != null) {
      linkval = json['linkval'];
      linkmarkers = [];
      for (int i = 0; i < linkval!; i++) {
        linkmarkers!.add(json['linkmarkers'][i]);
      }
    }
    if (json['card_sets'] != null) {
      cardSets = [];
      json['card_sets'].forEach((v) {
        cardSets!.add(YuGiOhCardSet.fromJson(v));
      });
    }
    if (json['card_images'] != null) {
      cardImages = [];
      json['card_images'].forEach((v) {
        cardImages!.add(CardImage.fromJson(v));
      });
    }
    if (json['card_prices'] != null) {
      cardPrices = CardPrices.fromJson(json['card_prices'][0]);
    }
    if (json['banlist_info'] != null) {
      banlistInfo = BanlistInfo.fromJson(json['banlist_info']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['id'] = cardId;
    data['name'] = name;
    data['type'] = type;
    data['desc'] = desc;
    data['race'] = race;
    if (atk != null) data['atk'] = atk;
    if (def != null) data['def'] = def;
    if (level != null) data['level'] = level;
    if (attribute != null) data['attribute'] = attribute;
    if (archetype != null) data['archetype'] = archetype;
    if (scale != null) data['scale'] = scale;
    if (linkval != null) data['linkval'] = linkval;
    if (linkmarkers != null) {
      data['linkmarkers'] = linkmarkers;
    }
    if (cardSets != null) {
      data['card_sets'] = cardSets!.map((v) => v.toJson()).toList();
    }
    if (cardImages != null) {
      data['card_images'] = cardImages!.map((v) => v.toJson()).toList();
    }
    if (cardPrices != null) {
      data['card_prices'] = cardPrices!.toJson();
    }
    if (banlistInfo != null) {
      data['banlist_info'] = banlistInfo!.toJson();
    }
    return data;
  }
}
