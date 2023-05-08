import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/cubit/deck_search_state.dart';
import 'package:flutter_app/models/deck.dart';
import 'package:flutter_app/network/helper/decks_helper.dart';
import 'package:flutter_app/network/response/response.dart';

class DeckSearchCubit extends Cubit<DeckSearchState> {
  List<Deck> decks = [];

  DeckSearchCubit() : super(DeckSearchInitial());

  emitInitialState() {
    decks = [];
    emit(DeckSearchInitial());
  }

  searchDecks(String query) async {
    emit(DeckSearchLoading());

    Response response = await DecksHelper.searchDecks(query);

    log(response.success.toString());

    if (response.success) {
      decks = response.obj as List<Deck>;
      emit(DeckSearchCompleted());
      return;
    }

    emit(DeckSearchFailed(response));
  }
}
