import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_button.dart';
import 'package:flutter_app/components/custom_text_field.dart';
import 'package:flutter_app/components/deck_list_tile.dart';
import 'package:flutter_app/cubit/decks_cubit.dart';
import 'package:flutter_app/models/deck.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckUi extends StatefulWidget {
  const DeckUi({super.key});

  @override
  State<DeckUi> createState() => _DeckUiState();
}

class _DeckUiState extends State<DeckUi> {
  List<Deck> decks = [];

  TextEditingController deckNameController = TextEditingController();

  @override
  void initState() {
    decks = BlocProvider.of<DecksCubit>(context).decks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text('Decks'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: decks.length,
        itemBuilder: (context, index) => DeckListTile(
          isEditable: true,
          deck: decks[index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Create new deck'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    hintText: 'deck name',
                    textEditingController: deckNameController,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: 'Create',
                          onPressed: () {
                            Navigator.of(context).pop();
                            BlocProvider.of<DecksCubit>(context)
                                .createDeck(deckNameController.text);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomButton(
                          title: 'Cancel',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
