import 'package:flutter/material.dart';

class TextButtonWithIconWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String label;

  const TextButtonWithIconWidget({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.add,
      ),
      label: Text(
        label,
        style: const TextStyle(
          decoration: TextDecoration.none,
          fontSize: 14,
        ),
      ),
    );
  }
}
