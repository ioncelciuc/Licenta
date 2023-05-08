part of 'deck_edit_cubit.dart';

abstract class DeckEditState {}

class DeckEditInitial extends DeckEditState {}

class DeckEditLoading extends DeckEditState {}

class DeckEditCompleted extends DeckEditState {}

class DeckEditSaved extends DeckEditState {}

class DeckEditFailed extends DeckEditState {
  final Response response;

  DeckEditFailed(this.response);
}
