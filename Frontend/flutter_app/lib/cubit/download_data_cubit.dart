import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/archetype.dart';
import 'package:flutter_app/models/card_set.dart';
import 'package:flutter_app/models/database_version.dart';
import 'package:flutter_app/models/translation.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/models/yugioh_image.dart';
import 'package:flutter_app/network/helper/download_data_helper.dart';
import 'package:flutter_app/network/response/response.dart';
import 'package:flutter_app/utils/hive_helper.dart';
import 'package:flutter_app/utils/shared_prefs_helper.dart';

part 'download_data_state.dart';

class DownloadDataCubit extends Cubit<DownloadDataState> {
  DownloadDataCubit() : super(DownloadDataInitial());

  downloadData() async {
    emit(DownloadDataLoading());

    SharedPrefsHelper.instance.setIsDataDownloaded(false);

    Response resDbVersion = await DownloadDataHelper.downloadDatabaseVersion();
    if (!resDbVersion.success) {
      emit(DownloadDataFailed(resDbVersion));
      return;
    }

    Response resCardSets = await DownloadDataHelper.downloadCardSets();
    if (!resCardSets.success) {
      emit(DownloadDataFailed(resCardSets));
      return;
    }

    Response resArchetypes = await DownloadDataHelper.downloadArchetypes();
    if (!resArchetypes.success) {
      emit(DownloadDataFailed(resArchetypes));
      return;
    }

    Response resCards = await DownloadDataHelper.downloadCards();
    if (!resCards.success) {
      emit(DownloadDataFailed(resCards));
      return;
    }

    Response resTranslations = await DownloadDataHelper.downloadTranslations();
    if (!resTranslations.success) {
      emit(DownloadDataFailed(resTranslations));
      return;
    }

    DatabaseVersion databaseVersion = resDbVersion.obj as DatabaseVersion;
    await HiveHelper.deleteDatabaseVersion();
    await HiveHelper.insertDatabaseVersion(databaseVersion);

    List<CardSet> cardSets = resCardSets.obj as List<CardSet>;
    await HiveHelper.deleteCardSets();
    await HiveHelper.insetCardSets(cardSets);

    List<Archetype> archetypes = resArchetypes.obj as List<Archetype>;
    await HiveHelper.deleteArchetypes();
    await HiveHelper.insetArchetypes(archetypes);

    List<YuGiOhCard> cards = resCards.obj as List<YuGiOhCard>;
    await HiveHelper.deleteCards();
    await HiveHelper.insetCards(cards);

    List<Translation> translations = resTranslations.obj as List<Translation>;
    await HiveHelper.deleteTranslations();
    await HiveHelper.insertTranslations(translations);

    SharedPrefsHelper.instance.setIsDataDownloaded(true);

    emit(DownloadDataCompleted());
  }

  downloadDataAndImages() async {
    emit(DownloadDataLoading());

    SharedPrefsHelper.instance.setIsDataDownloaded(false);

    Response resDbVersion = await DownloadDataHelper.downloadDatabaseVersion();
    if (!resDbVersion.success) {
      emit(DownloadDataFailed(resDbVersion));
      return;
    }

    Response resCardSets = await DownloadDataHelper.downloadCardSets();
    if (!resCardSets.success) {
      emit(DownloadDataFailed(resCardSets));
      return;
    }

    Response resArchetypes = await DownloadDataHelper.downloadArchetypes();
    if (!resArchetypes.success) {
      emit(DownloadDataFailed(resArchetypes));
      return;
    }

    Response resCards = await DownloadDataHelper.downloadCards();
    if (!resCards.success) {
      emit(DownloadDataFailed(resCards));
      return;
    }

    DatabaseVersion databaseVersion = resDbVersion.obj as DatabaseVersion;
    await HiveHelper.deleteDatabaseVersion();
    await HiveHelper.insertDatabaseVersion(databaseVersion);

    List<CardSet> cardSets = resCardSets.obj as List<CardSet>;
    await HiveHelper.deleteCardSets();
    await HiveHelper.insetCardSets(cardSets);

    List<Archetype> archetypes = resArchetypes.obj as List<Archetype>;
    await HiveHelper.deleteArchetypes();
    await HiveHelper.insetArchetypes(archetypes);

    List<YuGiOhCard> cards = resCards.obj as List<YuGiOhCard>;
    await HiveHelper.deleteCards();
    await HiveHelper.insetCards(cards);

    await HiveHelper.deleteImages();
    log('Downloading cards');
    int index = 1;
    for (YuGiOhCard card in cards) {
      log('Start Image nr. $index / ${cards.length} => ${card.cardId}');
      Response responseImage = await DownloadDataHelper.getImage(
        card.cardId.toString(),
      );
      if (!responseImage.success) {
        emit(DownloadDataFailed(responseImage));
        return;
      }
      YuGiOhImage image = responseImage.obj as YuGiOhImage;
      await HiveHelper.insertImage(image);
      index++;
    }

    SharedPrefsHelper.instance.setIsDataDownloaded(true);

    emit(DownloadDataCompleted());
  }
}
