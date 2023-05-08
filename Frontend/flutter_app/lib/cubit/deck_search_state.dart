import 'package:flutter_app/network/response/response.dart';

abstract class DeckSearchState {}

class DeckSearchInitial extends DeckSearchState {}

class DeckSearchLoading extends DeckSearchState {}

class DeckSearchCompleted extends DeckSearchState {}

class DeckSearchFailed extends DeckSearchState {
  final Response response;

  DeckSearchFailed(this.response);
}
