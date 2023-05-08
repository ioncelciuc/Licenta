import 'dart:convert';
import 'dart:developer';

import 'package:flutter_app/models/deck.dart';
import 'package:flutter_app/models/deck_card.dart';
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
      } else if (res.statusCode == 401) {
        log(res.statusCode.toString());
        log(res.body.toString());
        return Response(
          success: false,
          message: 'Login expired. Please log in again',
        );
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

  static Future<Response> getAllCardsFromDeck(Deck deck) async {
    try {
      final res = await http.get(
        Uri.parse('${DotEnvPaths().getCardsFromDeck()}/${deck.sId}'),
        headers: {"Authorization": "Bearer ${TokenHelper.getToken()}"},
      );

      if (res.statusCode >= 200 && res.statusCode <= 299) {
        final jsonList = jsonDecode(res.body);
        List<DeckCard> deckCards = [];
        for (var json in jsonList) {
          deckCards.add(DeckCard.fromJson(json as Map<String, dynamic>));
        }
        return Response(success: true, obj: deckCards);
      } else {
        return Response(
          success: false,
          message:
              'Get all cards from deck failed with status code ${res.statusCode}',
        );
      }
    } catch (e) {
      String message = "Error on get all cards from deck!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> deleteDeckAndContents(Deck deck) async {
    try {
      final res = await http.delete(
        Uri.parse('${DotEnvPaths().deleteDeck()}/${deck.sId}'),
        headers: {"Authorization": "Bearer ${TokenHelper.getToken()}"},
      );

      if (res.statusCode >= 200 && res.statusCode <= 299) {
        return Response(success: true);
      } else {
        return Response(
          success: false,
          message: 'Delete deck failed with status code ${res.statusCode}',
        );
      }
    } catch (e) {
      String message = "Error on delete deck!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }

  static Future<Response> saveDeckContents(
      Deck deck, List<DeckCard> deckCards) async {
    try {
      Map<String, dynamic> deckToSave = {};
      deckToSave['deckId'] = deck.sId;
      List<Map<String, dynamic>> cards = [];
      for (DeckCard deckCard in deckCards) {
        cards.add({
          "id": deckCard.cardId,
          "place": deckCard.place,
        });
      }
      deckToSave['cards'] = cards;
      log('Deck to save: $deckToSave');

      log(DotEnvPaths().saveDeckContent());

      final res = await http.post(
        Uri.parse(DotEnvPaths().saveDeckContent()),
        headers: {
          "Authorization": "Bearer ${TokenHelper.getToken()}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(deckToSave),
      );

      if (res.statusCode >= 200 && res.statusCode <= 299) {
        return Response(success: true);
      } else {
        return Response(success: false, message: res.body);
      }
    } catch (e) {
      String message = "Error on save deck!";
      log(message, error: e);
      return Response(
        success: false,
        message: message,
      );
    }
  }
}
