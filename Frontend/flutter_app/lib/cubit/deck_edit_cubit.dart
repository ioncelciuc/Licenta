import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/deck.dart';
import 'package:flutter_app/models/deck_card.dart';
import 'package:flutter_app/network/helper/decks_helper.dart';
import 'package:flutter_app/network/response/response.dart';

part 'deck_edit_state.dart';

class DeckEditCubit extends Cubit<DeckEditState> {
  late Deck deck;
  List<DeckCard> deckCards = [];

  DeckEditCubit() : super(DeckEditInitial());

  emitInitialState() {
    emit(DeckEditInitial());
  }

  setDeck(Deck deck) {
    this.deck = deck;
  }

  getAllCardsFromDeck(Deck deck) async {
    deckCards = [];
    emit(DeckEditLoading());

    Response response = await DecksHelper.getAllCardsFromDeck(deck);

    if (response.success) {
      deckCards = response.obj as List<DeckCard>;
      emit(DeckEditCompleted());
      return;
    }

    emit(DeckEditFailed(response));
  }

  addCardToMainDeckOrExtraDeck(String cardId, String cardType) {
    deckCards.add(
      DeckCard(
        cardId: cardId,
        deckId: deck.sId,
        place: (cardType.contains("Fusion") ||
                cardType.contains("Synchro") ||
                cardType.contains("XYZ") ||
                cardType.contains("Link"))
            ? 1
            : 0,
      ),
    );
  }

  removeCardFromMainDeckOrExtraDeck(String cardId) {
    DeckCard deckCard = deckCards.firstWhere((element) =>
        element.cardId == cardId && (element.place == 0 || element.place == 1));
    deckCards.remove(deckCard);
  }

  addCardToSideDeck(String cardId) {
    deckCards.add(
      DeckCard(
        cardId: cardId,
        deckId: deck.sId,
        place: 2,
      ),
    );
  }

  removeCardFromSideDeck(String cardId) {
    DeckCard deckCard = deckCards.firstWhere(
        (element) => element.cardId == cardId && element.place == 2);
    deckCards.remove(deckCard);
  }

  numberOfCardsInDeck(String cardId) {
    return deckCards.where((element) => element.cardId == cardId).length;
  }

  numberOfCardsInMainOrExtraDeck(String cardId) {
    return deckCards
        .where((element) =>
            element.cardId == cardId &&
            (element.place == 0 || element.place == 1))
        .length;
  }

  numberOfCardsInSideDeck(String cardId) {
    return deckCards
        .where((element) => element.cardId == cardId && element.place == 2)
        .length;
  }

  saveDeck() async {
    emit(DeckEditLoading());
    Response response = await DecksHelper.saveDeckContents(deck, deckCards);

    if (response.success) {
      emit(DeckEditSaved());
      return;
    }

    emit(DeckEditFailed(response));
  }
}
