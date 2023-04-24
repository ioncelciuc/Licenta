import 'package:flutter/material.dart';
import 'package:flutter_app/models/archetype.dart';
import 'package:flutter_app/screens/browse_archetypes/archetype_list_tile.dart';
import 'package:flutter_app/utils/hive_helper.dart';

class BrowseArchetypesScreen extends StatelessWidget {
  final String? searchParams;
  const BrowseArchetypesScreen({
    super.key,
    this.searchParams,
  });

  @override
  Widget build(BuildContext context) {
    List<Archetype> archetypes;
    if (searchParams != null) {
      archetypes = HiveHelper.getArchetypesByName(searchParams!);
    } else {
      archetypes = HiveHelper.getArchetypes();
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: archetypes.length,
        itemBuilder: (context, index) => ArchetypeListTile(
          archetype: archetypes[index],
        ),
      ),
    );
  }
}
