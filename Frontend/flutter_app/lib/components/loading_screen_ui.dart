import 'package:flutter/material.dart';

class LoadingScreenUi extends StatefulWidget {
  const LoadingScreenUi({super.key});

  @override
  State<LoadingScreenUi> createState() => _LoadingScreenUiState();
}

class _LoadingScreenUiState extends State<LoadingScreenUi> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
