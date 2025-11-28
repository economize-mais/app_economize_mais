import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:go_router/go_router.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool applyLeading;
  final dynamic title;
  final void Function()? localizationOnPressed;
  final bool hideActions;
  final bool? centerTitle;

  const GeneralAppBar({
    super.key,
    required this.title,
    this.applyLeading = true,
    this.localizationOnPressed,
    this.hideActions = false,
    this.centerTitle,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppScheme.brightGreen,
      foregroundColor: AppScheme.black,
      leadingWidth: 32,
      titleSpacing: 8,
      leading: IconButton(
        onPressed: applyLeading ? () => context.pop() : null,
        icon: Icon(applyLeading ? Icons.arrow_back_ios_new : null),
        iconSize: 16,
      ),
      centerTitle: centerTitle,
      title: title is String
          ? Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          : title,
      actions: !hideActions
          ? [
              TextButton.icon(
                onPressed: localizationOnPressed ?? () {},
                icon: const Icon(
                  Icons.room_outlined,
                  size: 14,
                ),
                label: const Text(
                  'Alfenas',
                  style: TextStyle(decoration: TextDecoration.none),
                ),
              ),
            ]
          : null,
    );
  }
}
