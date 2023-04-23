import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_button.dart';
import 'package:flutter_app/cubit/download_data_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadDataInitialUi extends StatelessWidget {
  const DownloadDataInitialUi({super.key});

  final String downloadDataExplanation =
      'You will have to download some data to have the possibility to use the app offline.\n\nNote that you have 2 options: "Only Card Data" and "Card Data and Images".\n\nWhen you download only the card data, the images will be loaded from our server every time an image is required.\nIf you access the app when you don\'t have internet access, the images of the cards will not appear.\nThis option requires about 50-100 MB of free storage.\n\nChossing the second option ensures the card images will be available at all times, regardless if you are connected to the internet or not.\nHowever, to do this, it is necessary to download all the card images into the device storage.\nNote that around 1.2 GB of free storage is required for this operation.';

  final String downloadDataExplanation2 =
      'You will have to download some data to have the possibility to use the app offline.\n\nThe storage required is about 50-100MB.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 32,
          ),
          child: Column(
            children: [
              const Text(
                'Download data',
                style: TextStyle(
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Scrollbar(
                thumbVisibility: true,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      downloadDataExplanation2,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              CustomButton(
                title: 'Download card data',
                onPressed: () {
                  BlocProvider.of<DownloadDataCubit>(context).downloadData();
                },
              ),
              // const SizedBox(height: 16),
              // CustomButton(
              //   title: 'Card Data and Images',
              //   onPressed: () {
              //     BlocProvider.of<DownloadDataCubit>(context)
              //         .downloadDataAndImages();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
