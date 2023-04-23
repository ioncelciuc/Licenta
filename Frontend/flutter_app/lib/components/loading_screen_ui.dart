import 'package:flutter/material.dart';

class LoadingScreenUi extends StatelessWidget {
  final String message;
  const LoadingScreenUi({
    super.key,
    this.message = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 64, left: 32, right: 32),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
