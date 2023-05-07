class Deck {
  String? sId;
  String? userId;
  String? name;
  int? mainDeckCount;
  int? extraDeckCount;
  int? sideDeckCount;

  Deck(
      {this.sId,
      this.userId,
      this.name,
      this.mainDeckCount,
      this.extraDeckCount,
      this.sideDeckCount});

  Deck.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    mainDeckCount = json['mainDeckCount'];
    extraDeckCount = json['extraDeckCount'];
    sideDeckCount = json['sideDeckCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['name'] = name;
    data['mainDeckCount'] = mainDeckCount;
    data['extraDeckCount'] = extraDeckCount;
    data['sideDeckCount'] = sideDeckCount;
    return data;
  }
}
