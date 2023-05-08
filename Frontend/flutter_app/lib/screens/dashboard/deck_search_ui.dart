import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/deck_list_tile.dart';
import 'package:flutter_app/cubit/deck_search_cubit.dart';
import 'package:flutter_app/models/deck.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckSearchUi extends StatefulWidget {
  const DeckSearchUi({super.key});

  @override
  State<DeckSearchUi> createState() => _DeckSearchUiState();
}

class _DeckSearchUiState extends State<DeckSearchUi> {
  List<Deck> decks = [];

  @override
  void initState() {
    decks = BlocProvider.of<DeckSearchCubit>(context).decks;
    log('DECK SEARCH RESULT LEN: ${decks.length}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: decks.length,
        itemBuilder: (context, index) => DeckListTile(
          isEditable: false,
          deck: decks[index],
        ),
      ),
    );
  }
}
