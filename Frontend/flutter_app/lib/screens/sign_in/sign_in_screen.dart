import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/loading_screen_ui.dart';
import 'package:flutter_app/components/snackbar_handler.dart';
import 'package:flutter_app/cubit/auth_cubit.dart';
import 'package:flutter_app/screens/sign_in/sign_in_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              message: "Sign in successfull",
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingScreenUi();
          }
          return const SignInUi();
        },
      ),
    );
  }
}
