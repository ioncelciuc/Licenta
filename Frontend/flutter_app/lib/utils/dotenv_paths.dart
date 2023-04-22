// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvPaths {
  final String _API_URL = 'API_URL_LOCAL';
  // final String _API_URL_LOCAL = 'API_URL_LOCAL';
  final String _AUTH_SIGN_UP = 'AUTH_SIGN_UP';
  final String _AUTH_SIGN_IN = 'AUTH_SIGN_IN';
  final String _AUTH_DELETE = 'AUTH_DELETE';
  final String _GET_DB_VERSION = 'GET_DB_VERSION';
  final String _GET_CARD_SETS = 'GET_CARD_SETS';
  final String _GET_ARCHETYPES = 'GET_ARCHETYPES';
  final String _GET_CARDS = 'GET_CARDS';
  final String _GET_IMAGE = 'GET_IMAGE';
  final String _GET_IMAGE_SMALL = 'GET_IMAGE_SMALL';
  final String _GET_IMAGE_CROPPED = 'GET_IMAGE_CROPPED';
  final String _CREATE_DECK = 'CREATE_DECK';
  final String _DELETE_DECK = 'DELETE_DECK';
  final String _SAVE_DECK_CONTENT = 'SAVE_DECK_CONTENT';
  final String _GET_USER_DECKS = 'GET_USER_DECKS';
  final String _GET_CARDS_FROM_DECK = 'GET_CARDS_FROM_DECK';
  final String _EMPTY_DECK = 'EMPTY_DECK';

  String signUp() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_AUTH_SIGN_UP]}';
    return path;
  }

  String signIn() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_AUTH_SIGN_IN]}';
    return path;
  }

  String deleteUser() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_AUTH_DELETE]}';
    return path;
  }

  String getDbVersion() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_GET_DB_VERSION]}';
    return path;
  }

  String getCardSets() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_GET_CARD_SETS]}';
    return path;
  }

  String getArchetpes() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_GET_ARCHETYPES]}';
    return path;
  }

  String getCards() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_GET_CARDS]}';
    return path;
  }

  String getImage() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_GET_IMAGE]}';
    return path;
  }

  String getImageSmall() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_GET_IMAGE_SMALL]}';
    return path;
  }

  String getImageCropped() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_GET_IMAGE_CROPPED]}';
    return path;
  }

  String createDeck() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_CREATE_DECK]}';
    return path;
  }

  String deleteDeck() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_DELETE_DECK]}';
    return path;
  }

  String saveDeckContent() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_SAVE_DECK_CONTENT]}';
    return path;
  }

  String getUserDecks() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_GET_USER_DECKS]}';
    return path;
  }

  String getCardsFromDeck() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_GET_CARDS_FROM_DECK]}';
    return path;
  }

  String emptyDeck() {
    String path = '${dotenv.env[_API_URL]}/${dotenv.env[_EMPTY_DECK]}';
    return path;
  }
}
