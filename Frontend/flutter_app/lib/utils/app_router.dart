import 'package:flutter/material.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/screens/browse_cards/browse_cards_screen.dart';
import 'package:flutter_app/screens/card_details/card_details_screen.dart';
import 'package:flutter_app/screens/deck/deck_screen.dart';
import 'package:flutter_app/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_app/screens/sign_up/sign_up_screen.dart';
import 'package:flutter_app/utils/card_list_type.dart';

class AppRouter {
  static void openCardDetailsPage(
    BuildContext context,
    YuGiOhCard card,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CardDetailsScreen(card: card),
      ),
    );
  }

  static void openCardListPage(
    BuildContext context,
    CardListType cardListType,
    String? searchParams,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BrowseCardsScreen(
          cardListType: cardListType,
          searchParams: searchParams,
        ),
      ),
    );
  }

  static void openSignInPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  static void openSignUpPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  static void openDecksPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DeckScreen(),
      ),
    );
  }
}
