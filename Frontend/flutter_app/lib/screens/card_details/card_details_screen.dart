import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar_card_details.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/screens/card_details/card_main_info_ui.dart';
import 'package:flutter_app/screens/card_details/card_prices_ui.dart';

class CardDetailsScreen extends StatefulWidget {
  final YuGiOhCard card;
  const CardDetailsScreen({
    super.key,
    required this.card,
  });

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;
  int index = 0;

  getCardDetailsPage(int index) {
    switch (index) {
      case 0:
        return CardMainInfoUi(card: widget.card);
      case 1:
        return CardPricesUi(card: widget.card);
      default:
        return CardMainInfoUi(card: widget.card);
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBarCardDetails(
        title: widget.card.name!,
        tabController: tabController,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
      ),
      body: getCardDetailsPage(index),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
