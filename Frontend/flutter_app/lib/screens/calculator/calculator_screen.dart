import 'package:flutter/material.dart';
import 'package:flutter_app/components/loading_screen_ui.dart';
import 'package:flutter_app/components/snackbar_handler.dart';
import 'package:flutter_app/cubit/calculator_cubit.dart';
import 'package:flutter_app/screens/calculator/calculator_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> homeScaffoldState;

  const CalculatorScreen({
    super.key,
    required this.homeScaffoldState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state is CalculatorFailed) {
          SnackbarHandler(
            context: context,
            isError: true,
            message: 'Error loading calculator data',
          );
        }
      },
      builder: (context, state) {
        if (state is CalculatorInitial) {
          BlocProvider.of<CalculatorCubit>(context).loadCalculatorValues();
          return const LoadingScreenUi();
        }
        if (state is CalculatorLoading) {
          return const LoadingScreenUi();
        }
        return CalculatorUi(homeScaffoldState: homeScaffoldState);
      },
    );
  }
}
