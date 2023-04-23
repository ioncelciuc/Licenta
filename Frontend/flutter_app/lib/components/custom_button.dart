import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? textPadding;
  final double? elevation;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.textPadding,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            child: Text(
              '$title',
              style: TextStyle(
                fontSize: 18,
                // color: AdaptiveTheme.of(context).mode.isDark
                //     ? Colors.black
                //     : Colors.white,
              ),
            ),
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            elevation: elevation ?? 0,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}
