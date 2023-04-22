import 'package:flutter_app/models/archetype.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/models/card_set.dart';
import 'package:flutter_app/models/database_version.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  static const String databaseVersion = 'database_version';
  static const String cardSets = 'card_sets';
  static const String archetypes = 'archetypes';
  static const String cards = 'cards';

  static DatabaseVersion getDatabaseVersion() {
    return Hive.box<DatabaseVersion>(databaseVersion).values.toList()[0];
  }

  static Future<void> insertDatabaseVersion(DatabaseVersion dbVersion) async {
    await Hive.box<DatabaseVersion>(databaseVersion).add(dbVersion);
  }

  static Future<void> deleteDatabaseVersion() async {
    await Hive.box<DatabaseVersion>(databaseVersion).clear();
  }

  static List<CardSet> getCardSets() {
    return Hive.box<CardSet>(cardSets).values.toList().cast<CardSet>();
  }

  static Future<void> insetCardSets(List<CardSet> cardSetsList) async {
    for (CardSet cardSet in cardSetsList) {
      await Hive.box<CardSet>(cardSets).add(cardSet);
    }
  }

  static Future<void> deleteCardSets() async {
    await Hive.box<CardSet>(cardSets).clear();
  }

  static List<Archetype> getArchetypes() {
    return Hive.box<Archetype>(archetypes).values.toList().cast<Archetype>();
  }

  static Future<void> insetArchetypes(List<Archetype> archetypesList) async {
    for (Archetype archetype in archetypesList) {
      await Hive.box<Archetype>(archetypes).add(archetype);
    }
  }

  static Future<void> deleteArchetypes() async {
    await Hive.box<Archetype>(archetypes).clear();
  }

  static List<YuGiOhCard> getCards() {
    return Hive.box<YuGiOhCard>(cards).values.toList().cast<YuGiOhCard>();
  }

  static Future<void> insetCards(List<YuGiOhCard> cardList) async {
    for (YuGiOhCard card in cardList) {
      await Hive.box<YuGiOhCard>(cards).add(card);
    }
  }

  static Future<void> deleteCards() async {
    await Hive.box<YuGiOhCard>(cards).clear();
  }
}
