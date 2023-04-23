import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/archetype.dart';
import 'package:flutter_app/models/card_set.dart';
import 'package:flutter_app/models/database_version.dart';
import 'package:flutter_app/models/yugioh_card.dart';
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

    SharedPrefsHelper.instance.setIsDataDownloaded(true);

    emit(DownloadDataCompleted());
  }
}
