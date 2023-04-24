import 'package:flutter/material.dart';
import 'package:flutter_app/models/archetype.dart';
import 'package:flutter_app/utils/app_router.dart';
import 'package:flutter_app/utils/card_list_type.dart';

class ArchetypeListTile extends StatelessWidget {
  final Archetype archetype;
  const ArchetypeListTile({
    super.key,
    required this.archetype,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
      elevation: 5,
      child: InkWell(
        onTap: () {
          AppRouter.openCardListPage(
            context,
            CardListType.ARCHETYPE_CARDS,
            archetype.archetypeName,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            archetype.archetypeName,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
