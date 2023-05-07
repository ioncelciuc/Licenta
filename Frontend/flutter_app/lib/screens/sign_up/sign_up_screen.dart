import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/loading_screen_ui.dart';
import 'package:flutter_app/components/snackbar_handler.dart';
import 'package:flutter_app/cubit/auth_cubit.dart';
import 'package:flutter_app/screens/sign_up/sign_up_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            log('entered auth failed in bloc consumer');
            SnackbarHandler(
              context: context,
              isError: true,
              message: state.response.message ?? "Unknown error occured",
            );
          }
          if (state is AuthCompleted) {
            log('entered auth completed in bloc consumer');
            SnackbarHandler(
              context: context,
              isError: false,
              message: "Account created successfully",
            );
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingScreenUi();
          }
          return const SignUpUi();
        },
      ),
    );
  }
}
