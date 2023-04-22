import 'package:hive/hive.dart';

part 'card_prices.g.dart';

@HiveType(typeId: 7)
class CardPrices {
  @HiveField(0)
  String? cardmarketPrice;

  @HiveField(1)
  String? tcgplayerPrice;

  @HiveField(2)
  String? ebayPrice;

  @HiveField(3)
  String? amazonPrice;

  @HiveField(4)
  String? coolstuffincPrice;

  CardPrices(
      {this.cardmarketPrice,
      this.tcgplayerPrice,
      this.ebayPrice,
      this.amazonPrice,
      this.coolstuffincPrice});

  CardPrices.fromJson(Map<String, dynamic> json) {
    cardmarketPrice = json['cardmarket_price'];
    tcgplayerPrice = json['tcgplayer_price'];
    ebayPrice = json['ebay_price'];
    amazonPrice = json['amazon_price'];
    coolstuffincPrice = json['coolstuffinc_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardmarket_price'] = cardmarketPrice;
    data['tcgplayer_price'] = tcgplayerPrice;
    data['ebay_price'] = ebayPrice;
    data['amazon_price'] = amazonPrice;
    data['coolstuffinc_price'] = coolstuffincPrice;
    return data;
  }
}
