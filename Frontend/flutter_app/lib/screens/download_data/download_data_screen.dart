import 'package:flutter/material.dart';
import 'package:flutter_app/components/loading_screen_ui.dart';
import 'package:flutter_app/cubit/download_data_cubit.dart';
import 'package:flutter_app/screens/download_data/download_data_failed_ui.dart';
import 'package:flutter_app/screens/download_data/download_data_initial_ui.dart';
import 'package:flutter_app/screens/initial/initial_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadDataScreen extends StatelessWidget {
  const DownloadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadDataCubit(),
      child: BlocConsumer<DownloadDataCubit, DownloadDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DownloadDataInitial) {
            return const DownloadDataInitialUi();
          }
          if (state is DownloadDataLoading) {
            return const LoadingScreenUi(
              message: 'Downloading Data...',
            );
          }
          if (state is DownloadDataFailed) {
            return const DownloadDataFailedUi();
          }
          return const InitialScreen();
        },
      ),
    );
  }
}
