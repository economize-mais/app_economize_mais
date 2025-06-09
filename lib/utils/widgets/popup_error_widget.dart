import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';

class PopupErrorWidget extends StatelessWidget {
  final String title;
  final String content;

  const PopupErrorWidget({
    super.key,
    this.title = 'Ops... Ocorreu um Erro',
    required this.content,
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
      iconPadding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      icon: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, size: 20),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppScheme.gray[4],
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          color: AppScheme.gray[4],
          fontSize: 14,
        ),
      ),
    );
  }
}
