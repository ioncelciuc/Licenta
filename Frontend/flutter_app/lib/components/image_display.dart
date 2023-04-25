import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/get_image_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageDisplay extends StatelessWidget {
  final String cardId;
  final String? banlist;

  const ImageDisplay({
    super.key,
    required this.cardId,
    this.banlist,
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
            );
            return Image.asset('assets/card_back.png');
          }
          if (state is GetImageLoading) {
            return Image.asset('assets/card_back.png');
          }
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.memory(
                base64Decode(
                  BlocProvider.of<GetImageCubit>(context).image,
                ),
              ),
              BlocProvider.of<GetImageCubit>(context).banlist != null
                  ? (BlocProvider.of<GetImageCubit>(context).banlist == 'Banned'
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.block,
                            color: Colors.red,
                          ),
                        )
                      : (BlocProvider.of<GetImageCubit>(context).banlist ==
                              'Limited'
                          ? Container(
                              color: Colors.black,
                              child: const Icon(
                                Icons.looks_one,
                                color: Colors.red,
                              ),
                            )
                          : Container(
                              color: Colors.black,
                              child: const Icon(
                                Icons.looks_two,
                                color: Colors.red,
                              ),
                            )))
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
