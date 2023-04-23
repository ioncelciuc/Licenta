import 'package:hive/hive.dart';

part 'yugioh_image.g.dart';

@HiveType(typeId: 8)
class YuGiOhImage {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? cardId;
  @HiveField(2)
  String? imageUrl;

  YuGiOhImage({
    this.id,
    this.cardId,
    this.imageUrl,
  });

  YuGiOhImage.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    cardId = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['id'] = cardId;
    data['image_url'] = imageUrl;
    return data;
  }
}
