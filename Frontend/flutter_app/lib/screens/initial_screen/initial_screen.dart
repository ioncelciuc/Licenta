import 'package:flutter/material.dart';
import 'package:flutter_app/models/archetype.dart';
import 'package:flutter_app/models/banlist_info.dart';
import 'package:flutter_app/models/card_image.dart';
import 'package:flutter_app/models/card_prices.dart';
import 'package:flutter_app/models/card_set.dart';
import 'package:flutter_app/models/database_version.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/models/yugioh_card_set.dart';
import 'package:flutter_app/screens/download_data_screen/download_data_screen.dart';
import 'package:flutter_app/utils/hive_helper.dart';
import 'package:flutter_app/utils/shared_prefs_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isLoading = true;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await dotenv.load();
    await SharedPrefsHelper.instance.initializeSharedPreferences();
    Hive.registerAdapter(DatabaseVersionAdapter());
    Hive.registerAdapter(CardSetAdapter());
    Hive.registerAdapter(ArchetypeAdapter());
    Hive.registerAdapter(YuGiOhCardAdapter());
    Hive.registerAdapter(YuGiOhCardSetAdapter());
    Hive.registerAdapter(CardImageAdapter());
    Hive.registerAdapter(BanlistInfoAdapter());
    Hive.registerAdapter(CardPricesAdapter());
    await Hive.openBox<DatabaseVersion>(HiveHelper.databaseVersion);
    await Hive.openBox<CardSet>(HiveHelper.cardSets);
    await Hive.openBox<Archetype>(HiveHelper.archetypes);
    await Hive.openBox<YuGiOhCard>(HiveHelper.cards);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (SharedPrefsHelper.instance.isDataDownloaded() == false) {
      return const DownloadDataScreen();
    }
    return const Scaffold();
  }
}
