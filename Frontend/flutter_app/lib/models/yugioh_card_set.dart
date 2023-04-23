import 'package:hive/hive.dart';

part 'yugioh_card_set.g.dart';

@HiveType(typeId: 4)
class YuGiOhCardSet {
  @HiveField(0)
  String? setName;

  @HiveField(1)
  String? setCode;

  @HiveField(2)
  String? setRarity;

  @HiveField(3)
  String? setRarityCode;

  @HiveField(4)
  String? setPrice;

  YuGiOhCardSet(
      {this.setName,
      this.setCode,
      this.setRarity,
      this.setRarityCode,
      this.setPrice});

  YuGiOhCardSet.fromJson(Map<String, dynamic> json) {
    setName = json['set_name'];
    setCode = json['set_code'];
    setRarity = json['set_rarity'];
    setRarityCode = json['set_rarity_code'];
    setPrice = json['set_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['set_name'] = setName;
    data['set_code'] = setCode;
    data['set_rarity'] = setRarity;
    data['set_rarity_code'] = setRarityCode;
    data['set_price'] = setPrice;
    return data;
  }
}
