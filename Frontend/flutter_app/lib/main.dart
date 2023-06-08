import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/calculator_cubit.dart';
import 'package:flutter_app/cubit/deck_edit_cubit.dart';
import 'package:flutter_app/cubit/deck_search_cubit.dart';
import 'package:flutter_app/cubit/decks_cubit.dart';
import 'package:flutter_app/cubit/favourite_cubit.dart';
import 'package:flutter_app/screens/initial/initial_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavouriteCubit()),
        BlocProvider(create: (context) => DecksCubit()),
        BlocProvider(create: (context) => DeckEditCubit()),
        BlocProvider(create: (context) => DeckSearchCubit()),
        BlocProvider(create: (context) => CalculatorCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yu-Gi-Oh! Companion',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.tealM3),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.tealM3,
        darkIsTrueBlack: true,
      ),
      themeMode: ThemeMode.system,
      home: const InitialScreen(),
    );
  }
}
