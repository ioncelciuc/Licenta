import 'package:flutter_app/models/archetype.dart';
import 'package:flutter_app/models/calculator_data.dart';
import 'package:flutter_app/models/counter.dart';
import 'package:flutter_app/models/favourite_card.dart';
import 'package:flutter_app/models/translation.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/models/card_set.dart';
import 'package:flutter_app/models/database_version.dart';
import 'package:flutter_app/models/yugioh_card_set.dart';
import 'package:flutter_app/models/yugioh_image.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  static const String databaseVersion = 'database_version';
  static const String cardSets = 'card_sets';
  static const String archetypes = 'archetypes';
  static const String cards = 'cards';
  static const String images = 'images';
  static const String favourites = 'favourites';
  static const String translations = 'translations';
  static const String calculatorData = 'calculator_data';

  static Future<CalculatorData> getCalculatorData() async {
    CalculatorData cd;
    List<CalculatorData> cdList =
        Hive.box<CalculatorData>(calculatorData).values.toList();
    if (cdList.isEmpty) {
      cd = CalculatorData(
        lp1Evo: [8000],
        lp2Evo: [8000],
        lp1: 8000,
        lp2: 8000,
        lp1Selected: true,
        counters: List<Counter>.filled(24, Counter(), growable: false),
      );
      await insertCalculatorData(cd);
    } else {
      cd = cdList[0];
    }
    return cd;
  }

  static Future<void> insertCalculatorData(CalculatorData cd) async {
    await Hive.box<CalculatorData>(calculatorData).clear();
    await Hive.box<CalculatorData>(calculatorData).add(cd);
  }

  static DatabaseVersion getDatabaseVersion() {
    return Hive.box<DatabaseVersion>(databaseVersion).values.toList()[0];
  }

  static Future<void> insertDatabaseVersion(DatabaseVersion dbVersion) async {
    await Hive.box<DatabaseVersion>(databaseVersion).add(dbVersion);
  }

  static Future<void> deleteDatabaseVersion() async {
    await Hive.box<DatabaseVersion>(databaseVersion).clear();
  }

  static CardSet getCardSet(String setName) {
    return Hive.box<CardSet>(cardSets)
        .values
        .firstWhere((element) => element.setName == setName);
  }

  static List<YuGiOhCard> getCardsFromSet(String setName) {
    return Hive.box<YuGiOhCard>(cards).values.where((card) {
      YuGiOhCardSet cardSet = card.cardSets!.firstWhere(
          (set) => set.setName == setName,
          orElse: () => YuGiOhCardSet());
      return cardSet.setName != null;
    }).toList();
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

  static List<Archetype> getArchetypesByName(String seachParams) {
    return Hive.box<Archetype>(archetypes)
        .values
        .where((element) =>
            element.archetypeName.toLowerCase().contains(seachParams))
        .toList();
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

  static YuGiOhCard getCardById(int cardId) {
    return Hive.box<YuGiOhCard>(cards)
        .values
        .firstWhere((element) => element.cardId == cardId);
  }

  static List<YuGiOhCard> getBannedCards() {
    List<YuGiOhCard> bannedCards =
        Hive.box<YuGiOhCard>(cards).values.where((element) {
      if (element.banlistInfo == null) {
        return false;
      }
      if (element.banlistInfo!.banTcg == null) {
        return false;
      }
      return true;
    }).toList();
    bannedCards.sort((a, b) {
      //banned, then limited, then semi-limited
      if (a.banlistInfo!.banTcg == 'Banned' &&
          b.banlistInfo!.banTcg != 'Banned') {
        return -1;
      }
      if (a.banlistInfo!.banTcg != 'Banned' &&
          b.banlistInfo!.banTcg == 'Banned') {
        return 1;
      }
      if (a.banlistInfo!.banTcg == 'Limited' &&
          b.banlistInfo!.banTcg != 'Limited') {
        return -1;
      }
      if (a.banlistInfo!.banTcg != 'Limited' &&
          b.banlistInfo!.banTcg == 'Limited') {
        return 1;
      }
      //monsters, then spells, then traps
      if (a.type!.contains('Monster') && !b.type!.contains('Monster')) {
        return -1;
      }
      if (!a.type!.contains('Monster') && b.type!.contains('Monster')) {
        return 1;
      }
      if (a.type!.contains('Spell') && !b.type!.contains('Spell')) {
        return -1;
      }
      if (!a.type!.contains('Spell') && b.type!.contains('Spell')) {
        return 1;
      }
      if (a.type!.contains('Monster') && b.type!.contains('Monster')) {
        if (a.type!.contains('Normal') && !b.type!.contains('Normal')) {
          return -1;
        }
        if (!a.type!.contains('Normal') && b.type!.contains('Normal')) {
          return 1;
        }

        if ((a.type!.startsWith('Effect') && !b.type!.startsWith('Effect')) ||
            (a.type!.startsWith('Flip') && !b.type!.startsWith('Flip')) ||
            (a.type!.startsWith('Toon') && !b.type!.startsWith('Toon')) ||
            (a.type!.startsWith('Spirit') && !b.type!.startsWith('Spirit')) ||
            (a.type!.startsWith('Union') && !b.type!.startsWith('Union')) ||
            (a.type!.startsWith('Gemini') && !b.type!.startsWith('Gemini')) ||
            (a.type!.startsWith('Tuner') && !b.type!.startsWith('Tuner'))) {
          return -1;
        }
        if ((!a.type!.startsWith('Effect') && b.type!.startsWith('Effect')) ||
            (!a.type!.startsWith('Flip') && b.type!.startsWith('Flip')) ||
            (!a.type!.startsWith('Toon') && b.type!.startsWith('Toon')) ||
            (!a.type!.startsWith('Spirit') && b.type!.startsWith('Spirit')) ||
            (!a.type!.startsWith('Union') && b.type!.startsWith('Union')) ||
            (!a.type!.startsWith('Gemini') && b.type!.startsWith('Gemini')) ||
            (!a.type!.startsWith('Tuner') && b.type!.startsWith('Tuner'))) {
          return 1;
        }

        if (a.type!.startsWith('Fusion') && !b.type!.contains('Fusion')) {
          return -1;
        }
        if (!a.type!.startsWith('Fusion') && b.type!.contains('Fusion')) {
          return 1;
        }

        if (a.type!.startsWith('Synchro') && !b.type!.contains('Synchro')) {
          return -1;
        }
        if (!a.type!.startsWith('Synchro') && b.type!.contains('Synchro')) {
          return 1;
        }

        if (a.type!.startsWith('XYZ') && !b.type!.contains('XYZ')) {
          return -1;
        }
        if (!a.type!.startsWith('XYZ') && b.type!.contains('XYZ')) {
          return 1;
        }

        if (a.type!.contains('Pendulum') && !b.type!.contains('Pendulum')) {
          return -1;
        }
        if (!a.type!.contains('Pendulum') && b.type!.contains('Pendulum')) {
          return 1;
        }

        if (a.type!.contains('Link') && !b.type!.contains('Link')) {
          return -1;
        }
        if (!a.type!.contains('Link') && b.type!.contains('Link')) {
          return 1;
        }
      }
      return a.name!.compareTo(b.name!);
    });
    return bannedCards;
  }

  static List<YuGiOhCard> getArchetypeCards(String archetype) {
    return Hive.box<YuGiOhCard>(cards)
        .values
        .where((element) => element.archetype == archetype)
        .toList();
  }

  static Future<void> insetCards(List<YuGiOhCard> cardList) async {
    for (YuGiOhCard card in cardList) {
      await Hive.box<YuGiOhCard>(cards).add(card);
    }
  }

  static Future<void> deleteCards() async {
    await Hive.box<YuGiOhCard>(cards).clear();
  }

  static Future<void> insertTranslations(
    List<Translation> translationList,
  ) async {
    for (Translation translation in translationList) {
      await Hive.box<Translation>(translations).add(translation);
    }
  }

  static List<Translation> getCardsByTranslationNameOrId(String query) {
    return Hive.box<Translation>(translations)
        .values
        .where((element) =>
            element.name!.toLowerCase().contains(query.toLowerCase()) ||
            element.cardId.toString().contains(query))
        .toList();
  }

  static Future<void> deleteTranslations() async {
    await Hive.box<Translation>(translations).clear();
  }

  static Future<void> insertImage(YuGiOhImage image) async {
    await Hive.box<YuGiOhImage>(images).add(image);
  }

  static Future<void> deleteImages() async {
    await Hive.box<YuGiOhImage>(images).clear();
  }

  static YuGiOhImage getImage(String cardId) {
    return Hive.box<YuGiOhImage>(images).values.firstWhere(
        (image) => image.cardId == cardId,
        orElse: () => YuGiOhImage());
  }

  static Future<void> insertFavourite(int cardId) async {
    await Hive.box<FavouriteCard>(favourites).add(FavouriteCard(cardId));
  }

  static Future<void> deleteFavourite(int cardId) async {
    final box = Hive.box<FavouriteCard>(favourites);
    final keysToDelete =
        box.keys.where((key) => box.get(key)!.cardId == cardId).toList();
    await box.deleteAll(keysToDelete);
  }

  static List<YuGiOhCard> getFavourites() {
    List<FavouriteCard> favouriteCards =
        Hive.box<FavouriteCard>(favourites).values.toList();
    List<YuGiOhCard> yugiohCards = [];
    for (FavouriteCard favouriteCard in favouriteCards) {
      yugiohCards.add(Hive.box<YuGiOhCard>(cards)
          .values
          .firstWhere((element) => element.cardId == favouriteCard.cardId));
    }
    return yugiohCards;
  }

  static bool isFavourite(int cardId) {
    int id = Hive.box<FavouriteCard>(favourites)
        .values
        .firstWhere((element) => element.cardId == cardId,
            orElse: () => FavouriteCard(-1))
        .cardId;
    return id != -1;
  }
}
