import 'package:flutter/material.dart';

class UtilityButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;

  const UtilityButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: const BorderSide(width: 0.5),
            ),
          ),
        ),
        onPressed: onPressed,
        child: icon,
      ),
    );
  }
}
