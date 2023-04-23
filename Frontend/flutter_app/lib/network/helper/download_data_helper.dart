import 'dart:convert';
import 'dart:developer';

import 'package:flutter_app/models/archetype.dart';
import 'package:flutter_app/models/card_set.dart';
import 'package:flutter_app/models/database_version.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/models/yugioh_image.dart';
import 'package:flutter_app/network/response/response.dart';
import 'package:flutter_app/utils/dotenv_paths.dart';
import 'package:http/http.dart' as http;

class DownloadDataHelper {
  static Future<Response> downloadDatabaseVersion() async {
    try {
      String path = DotEnvPaths().getDbVersion();
      http.Response res = await http.get(Uri.parse(path));
      final jsonList = jsonDecode(res.body);
      final json = jsonList[0];
      DatabaseVersion databaseVersion = DatabaseVersion.fromJson(json);
      return Response(success: true, obj: databaseVersion);
    } catch (e) {
      String message = "Error on download database version!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> downloadCardSets() async {
    try {
      String path = DotEnvPaths().getCardSets();
      http.Response res = await http.get(Uri.parse(path));
      final jsonList = jsonDecode(res.body);
      List<CardSet> cardSets = [];
      for (var json in jsonList) {
        cardSets.add(CardSet.fromJson(json));
      }
      return Response(success: true, obj: cardSets);
    } catch (e) {
      String message = "Error on download card sets!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> downloadArchetypes() async {
    try {
      String path = DotEnvPaths().getArchetpes();
      http.Response res = await http.get(Uri.parse(path));
      final jsonList = jsonDecode(res.body);
      List<Archetype> archetypes = [];
      for (var json in jsonList) {
        archetypes.add(Archetype.fromJson(json));
      }
      return Response(success: true, obj: archetypes);
    } catch (e) {
      String message = "Error on download archetypes!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> downloadCards() async {
    try {
      String path = DotEnvPaths().getCards();
      http.Response res = await http.get(Uri.parse(path));
      final jsonList = jsonDecode(res.body);
      List<YuGiOhCard> cards = [];
      for (var json in jsonList) {
        cards.add(YuGiOhCard.fromJson(json));
      }
      return Response(success: true, obj: cards);
    } catch (e) {
      String message = "Error on download cards!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> getImage(String cardId) async {
    try {
      String path = '${DotEnvPaths().getImage()}/$cardId';
      http.Response res = await http.get(Uri.parse(path));
      final jsonList = jsonDecode(res.body);
      final json = jsonList[0];
      YuGiOhImage image = YuGiOhImage.fromJson(json);
      return Response(success: true, obj: image);
    } catch (e) {
      String message = "Error on download image with id: $cardId!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }
}
