import 'package:hive/hive.dart';

part 'card_set.g.dart';

@HiveType(typeId: 1)
class CardSet {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? setName;

  @HiveField(2)
  String? setCode;

  @HiveField(3)
  int? numOfCards;

  @HiveField(4)
  String? tcgDate;

  CardSet({
    this.id,
    this.setName,
    this.setCode,
    this.numOfCards,
    this.tcgDate,
  });

  CardSet.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    setName = json['set_name'];
    setCode = json['set_code'];
    numOfCards = json['num_of_cards'];
    tcgDate = json['tcg_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['set_name'] = setName;
    data['set_code'] = setCode;
    data['num_of_cards'] = numOfCards;
    data['tcg_date'] = tcgDate;
    return data;
  }
}
