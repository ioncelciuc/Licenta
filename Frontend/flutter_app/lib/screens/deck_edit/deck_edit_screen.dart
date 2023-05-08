import 'package:flutter/material.dart';
import 'package:flutter_app/components/loading_screen_ui.dart';
import 'package:flutter_app/components/snackbar_handler.dart';
import 'package:flutter_app/cubit/deck_edit_cubit.dart';
import 'package:flutter_app/cubit/decks_cubit.dart';
import 'package:flutter_app/models/deck.dart';
import 'package:flutter_app/screens/deck_edit/deck_edit_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckEditScreen extends StatelessWidget {
  final Deck deck;

  const DeckEditScreen({
    super.key,
    required this.deck,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DeckEditCubit>(context).emitInitialState();
    BlocProvider.of<DeckEditCubit>(context).setDeck(deck);
    return BlocConsumer<DeckEditCubit, DeckEditState>(
      listener: (context, state) {
        if (state is DeckEditFailed) {
          SnackbarHandler(
            context: context,
            isError: true,
            message: state.response.message ?? "Unknown error occured",
          );
        }
        if (state is DeckEditSaved) {
          Navigator.of(context).pop();
          BlocProvider.of<DecksCubit>(context).emitInitialState();
        }
      },
      builder: (context, state) {
        if (state is DeckEditInitial) {
          BlocProvider.of<DeckEditCubit>(context).getAllCardsFromDeck(deck);
          return const LoadingScreenUi();
        }
        if (state is DeckEditLoading) {
          return const LoadingScreenUi();
        }
        return DeckEditUi(deck: deck);
      },
    );
  }
}
