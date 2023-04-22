import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
