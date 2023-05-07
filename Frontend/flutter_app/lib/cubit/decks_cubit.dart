import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/deck.dart';
import 'package:flutter_app/network/helper/decks_helper.dart';
import 'package:flutter_app/network/response/response.dart';

part 'decks_state.dart';

class DecksCubit extends Cubit<DecksState> {
  List<Deck> decks = [];

  DecksCubit() : super(DecksInitial());

  getDecks() async {
    emit(DecksLoading());

    Response response = await DecksHelper.getAllDecks();

    if (response.success) {
      decks = response.obj as List<Deck>;
      emit(DecksCompleted());
      return;
    }

    emit(DecksFailed(response));
  }

  createDeck(String name) async {
    emit(DecksLoading());

    Response response = await DecksHelper.createDeck(name);

    if (response.success) {
      emit(DecksInitial()); //to get the newly created deck
      return;
    }

    emit(DecksFailed(response));
  }
}
