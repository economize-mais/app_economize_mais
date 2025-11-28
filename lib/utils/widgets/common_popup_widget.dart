import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonPopupWidget extends StatelessWidget {
  final String title;

  const CommonPopupWidget({
    super.key,
    this.title = 'Nova senha enviada por e-mail.',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppScheme.white,
      elevation: 2,
      shadowColor: AppScheme.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: AppScheme.lightGray),
      ),
      icon: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.close, size: 20),
        ),
      ),
      iconPadding: const EdgeInsets.only(top: 10, right: 10),
      title: Text(title),
      titlePadding: const EdgeInsets.only(bottom: 30),
    );
  }
}
