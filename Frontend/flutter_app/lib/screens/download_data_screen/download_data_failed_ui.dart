import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/download_data_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadDataFailedUi extends StatelessWidget {
  const DownloadDataFailedUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Retry'),
          onPressed: () {
            BlocProvider.of<DownloadDataCubit>(context).downloadData();
          },
        ),
      ),
    );
  }
}
