import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/get_image_cubit.dart';
import 'package:flutter_app/utils/image_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => GetImageCubit(),
      child: BlocConsumer<GetImageCubit, GetImageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetImageInitial) {
            BlocProvider.of<GetImageCubit>(context).getImage(
              cardId,
              banlist,
              imageType,
            );
            return Image.asset('assets/card_back.png');
          }
          if (state is GetImageLoading) {
            return Image.asset('assets/card_back.png');
          }
          return Image.memory(
            base64Decode(
              BlocProvider.of<GetImageCubit>(context).image,
            ),
          );
        },
      ),
    );
  }
}
