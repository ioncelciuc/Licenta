import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/utils/hive_helper.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  List<YuGiOhCard> cards = [];

  FavouriteCubit() : super(FavouriteInitial());

  emitFavouriteInitial() {
    emit(FavouriteInitial());
  }

  getFavouriteCards() async {
    emit(FavouriteLoading());
    cards = HiveHelper.getFavourites();
    await Future.delayed(const Duration(milliseconds: 200));
    emit(FavouriteCompleted());
  }

  addFavourite(int cardId) async {
    emit(FavouriteLoading());
    await HiveHelper.insertFavourite(cardId);
    emit(FavouriteCompleted());
  }

  deleteFavourite(int cardId) async {
    emit(FavouriteLoading());
    await HiveHelper.deleteFavourite(cardId);
    cards.removeWhere((element) => element.cardId == cardId);
    emit(FavouriteCompleted());
  }
}
