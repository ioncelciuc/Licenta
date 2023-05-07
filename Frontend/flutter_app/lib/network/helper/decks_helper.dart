import 'dart:convert';
import 'dart:developer';

import 'package:flutter_app/models/deck.dart';
import 'package:flutter_app/utils/dotenv_paths.dart';
import 'package:flutter_app/utils/token_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/network/response/response.dart';

class DecksHelper {
  static Future<Response> getAllDecks() async {
    try {
      final res = await http.get(
        Uri.parse(DotEnvPaths().getUserDecks()),
        headers: {"Authorization": "Bearer ${TokenHelper.getToken()}"},
      );

      if (res.statusCode >= 200 && res.statusCode <= 299) {
        List<Deck> decks = [];
        final jsonList = jsonDecode(res.body);
        for (var json in jsonList) {
          decks.add(Deck.fromJson(json as Map<String, dynamic>));
        }
        return Response(success: true, obj: decks);
      } else {
        return Response(
          success: false,
          message: 'Get all decks failed with status code ${res.statusCode}',
        );
      }
    } catch (e) {
      String message = "Error on get all decks!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> createDeck(String name) async {
    try {
      final res = await http.post(
        Uri.parse(DotEnvPaths().createDeck()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${TokenHelper.getToken()}",
        },
        body: jsonEncode(
          {
            "name": name,
          },
        ),
      );

      if (res.statusCode >= 200 && res.statusCode <= 299) {
        return Response(success: true);
      } else {
        return Response(
          success: false,
          message: 'Deck creation failed with status code ${res.statusCode}',
        );
      }
    } catch (e) {
      String message = "Error on deck creation!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }
}
