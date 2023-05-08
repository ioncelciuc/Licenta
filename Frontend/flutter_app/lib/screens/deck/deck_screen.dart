import 'package:flutter/material.dart';
import 'package:flutter_app/components/loading_screen_ui.dart';
import 'package:flutter_app/components/snackbar_handler.dart';
import 'package:flutter_app/cubit/decks_cubit.dart';
import 'package:flutter_app/screens/deck/deck_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckScreen extends StatelessWidget {
  const DeckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DecksCubit>(context).emitInitialState();
    return BlocConsumer<DecksCubit, DecksState>(
      listener: (context, state) {
        if (state is DecksFailed) {
          SnackbarHandler(
            context: context,
            isError: true,
            message: state.response.message ?? "Unknown error occured",
          );
        }
      },
      builder: (context, state) {
        if (state is DecksInitial) {
          BlocProvider.of<DecksCubit>(context).getDecks();
          return const LoadingScreenUi();
        }
        if (state is DecksLoading) {
          return const LoadingScreenUi();
        }
        //check for failed ui
        return const DeckUi();
      },
    );
  }
}
