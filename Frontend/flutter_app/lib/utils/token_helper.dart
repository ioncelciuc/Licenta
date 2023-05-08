import 'dart:developer';

import 'package:flutter_app/utils/shared_prefs_helper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHelper {
  static String getToken() {
    return SharedPrefsHelper.instance.getAuthToken();
  }

  static bool tokenExistsAndIsValid() {
    if (SharedPrefsHelper.instance.getAuthToken().isNotEmpty) {
      log('CURRENT DATE: ${DateTime.now()}');
      log('TOKEN EXPIRATION DATE: ${getExpirationDate()}');
      bool isExpired;
      try {
        isExpired =
            JwtDecoder.isExpired(SharedPrefsHelper.instance.getAuthToken());
        return !isExpired;
      } catch (e) {
        log('TOKEN ERROR: $e');
        return false;
      }
    }
    return false;
  }

  static String getUser() {
    String token = SharedPrefsHelper.instance.getAuthToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['username'];
  }

  static String getUserId() {
    String token = SharedPrefsHelper.instance.getAuthToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['id'];
  }

  static DateTime getExpirationDate() {
    String token = SharedPrefsHelper.instance.getAuthToken();
    return JwtDecoder.getExpirationDate(token);
  }
}
