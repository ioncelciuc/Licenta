import 'package:hive/hive.dart';
part 'translation.g.dart';

@HiveType(typeId: 10)
class Translation {
  @HiveField(0)
  String? id;

  @HiveField(1)
  int? cardId;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? languageCode;

  Translation({
    this.id,
    this.cardId,
    this.name,
    this.languageCode,
  });

  Translation.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    cardId = json['id'];
    name = json['name'];
    languageCode = json['language_code'];
  }

  toJson() {
    Map<String, dynamic> json = {};
    json['_id'] = id;
    json['id'] = cardId;
    json['name'] = name;
    json['language_code'] = languageCode;
    return json;
  }
}
