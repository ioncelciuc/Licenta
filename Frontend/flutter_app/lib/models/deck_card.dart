class DeckCard {
  String? sId;
  String? deckId;
  String? cardId;
  int? place;

  DeckCard({this.sId, this.deckId, this.cardId, this.place});

  DeckCard.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    deckId = json['deckId'];
    cardId = json['cardId'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['deckId'] = deckId;
    data['cardId'] = cardId;
    data['place'] = place;
    return data;
  }
}
