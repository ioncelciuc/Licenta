import 'package:hive/hive.dart';

part 'card_image.g.dart';

@HiveType(typeId: 6)
class CardImage {
  @HiveField(0)
  String? imageUrl;

  @HiveField(1)
  String? imageUrlSmall;

  CardImage({this.imageUrl, this.imageUrlSmall});

  CardImage.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    imageUrlSmall = json['image_url_small'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['image_url_small'] = imageUrlSmall;
    return data;
  }
}
