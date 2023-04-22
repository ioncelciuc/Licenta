// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  SharedPrefsHelper._privateConstructor();
  static final SharedPrefsHelper _instance =
      SharedPrefsHelper._privateConstructor();
  static SharedPrefsHelper get instance => _instance;

  late SharedPreferences _sharedPreferences;

  static const String _IS_DATA_DOWNLOADED = 'IS_DATA_DOWNLOADED';

  Future<void> initializeSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool isDataDownloaded() {
    return _sharedPreferences.getBool(_IS_DATA_DOWNLOADED) ?? false;
  }

  Future<void> setIsDataDownloaded(bool isTheDataDownloaded) async {
    await _sharedPreferences.setBool(_IS_DATA_DOWNLOADED, isTheDataDownloaded);
  }
}
