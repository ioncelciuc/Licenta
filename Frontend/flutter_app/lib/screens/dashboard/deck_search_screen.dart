import 'package:flutter/material.dart';
import 'package:flutter_app/components/loading_screen_ui.dart';
import 'package:flutter_app/components/snackbar_handler.dart';
import 'package:flutter_app/cubit/deck_search_cubit.dart';
import 'package:flutter_app/cubit/deck_search_state.dart';
import 'package:flutter_app/screens/dashboard/deck_search_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckSearchScreen extends StatelessWidget {
  final String query;

  const DeckSearchScreen({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DeckSearchCubit>(context).emitInitialState();
    return BlocConsumer<DeckSearchCubit, DeckSearchState>(
      listener: (context, state) {
        if (state is DeckSearchFailed) {
          SnackbarHandler(
            context: context,
            isError: true,
            message: state.response.message ?? "Unknown error occured",
          );
        }
      },
      builder: (context, state) {
        if (state is DeckSearchInitial) {
          BlocProvider.of<DeckSearchCubit>(context).searchDecks(query);
          return const LoadingScreenUi();
        }
        if (state is DeckSearchLoading) {
          return const LoadingScreenUi();
        }
        return const DeckSearchUi();
      },
    );
  }
}
