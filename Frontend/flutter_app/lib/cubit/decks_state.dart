part of 'decks_cubit.dart';

abstract class DecksState {}

class DecksInitial extends DecksState {}

class DecksLoading extends DecksState {}

class DecksCompleted extends DecksState {}

class DecksFailed extends DecksState {
  final Response response;

  DecksFailed(this.response);
}
