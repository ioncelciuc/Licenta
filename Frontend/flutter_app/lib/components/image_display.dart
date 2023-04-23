import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/get_image_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageDisplay extends StatelessWidget {
  final String cardId;

  const ImageDisplay({
    super.key,
    required this.cardId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetImageCubit(),
      child: BlocConsumer<GetImageCubit, GetImageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetImageInitial) {
            BlocProvider.of<GetImageCubit>(context).getImage(cardId);
            return Image.asset('assets/card_back.png');
          }
          if (state is GetImageLoading) {
            return Image.asset('assets/card_back.png');
          }
          return Image.memory(base64Decode(
            BlocProvider.of<GetImageCubit>(context).image,
          ));
        },
      ),
    );
  }
}
