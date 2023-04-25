import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar_card_details.dart';
import 'package:flutter_app/cubit/favourite_cubit.dart';
import 'package:flutter_app/models/yugioh_card.dart';
import 'package:flutter_app/screens/card_details/card_main_info_ui.dart';
import 'package:flutter_app/screens/card_details/card_prices_ui.dart';
import 'package:flutter_app/utils/hive_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late bool isFavourite;

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
    isFavourite = HiveHelper.isFavourite(widget.card.cardId!);
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
        actions: [
          IconButton(
            onPressed: () async {
              if (isFavourite) {
                await BlocProvider.of<FavouriteCubit>(context)
                    .deleteFavourite(widget.card.cardId!);
              } else {
                await BlocProvider.of<FavouriteCubit>(context)
                    .addFavourite(widget.card.cardId!);
              }
              setState(() {
                isFavourite = !isFavourite;
              });
              BlocProvider.of<FavouriteCubit>(context).emitFavouriteInitial();
            },
            icon: isFavourite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: getCardDetailsPage(index),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
