import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/image_type.dart';

class ImageDisplay extends StatelessWidget {
  final String cardId;
  final String? banlist;
  final ImageType imageType;

  const ImageDisplay({
    super.key,
    required this.cardId,
    this.banlist,
    this.imageType = ImageType.CARD,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          'https://ygocompanion.s3.eu-central-1.amazonaws.com/${imageType == ImageType.CARD ? 'images' : 'images_small'}/$cardId.jpg',
      placeholder: (context, url) => Image.asset(
        'assets/card_back.png',
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/card_back.png',
      ),
    );
  }
}
