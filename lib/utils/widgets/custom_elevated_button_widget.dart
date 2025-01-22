import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final IconData iconData;
  final double iconSize;

  const CustomElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.iconData = Icons.arrow_forward_ios,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          backgroundColor: AppScheme.white,
          foregroundColor: AppScheme.gray[4]!,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: AppScheme.gray[1]!,
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Icon(
              iconData,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
