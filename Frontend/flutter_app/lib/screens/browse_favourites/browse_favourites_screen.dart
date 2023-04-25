import 'package:flutter/material.dart';
import 'package:flutter_app/components/loading_screen_ui.dart';
import 'package:flutter_app/cubit/favourite_cubit.dart';
import 'package:flutter_app/screens/browse_cards/browse_cards_screen.dart';
import 'package:flutter_app/utils/card_list_type.dart';
import 'package:flutter_app/utils/card_search_delegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowseFavouritesScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> homeScaffoldState;

  const BrowseFavouritesScreen({
    super.key,
    required this.homeScaffoldState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FavouriteInitial) {
          BlocProvider.of<FavouriteCubit>(context).getFavouriteCards();
          return const LoadingScreenUi();
        }
        if (state is FavouriteLoading) {
          return const LoadingScreenUi();
        }
        if (state is FavouriteCompleted) {
          return Scaffold(
            appBar: AppBar(
              elevation: 10,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  homeScaffoldState.currentState!.openDrawer();
                },
              ),
              title: const Text('Favourites'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CardSearchDelegate(
                        listType: CardListType.FAVOURITE_CARDS,
                      ),
                    );
                  },
                ),
              ],
            ),
            body: const BrowseCardsScreen(
              cardListType: CardListType.FAVOURITE_CARDS,
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}
