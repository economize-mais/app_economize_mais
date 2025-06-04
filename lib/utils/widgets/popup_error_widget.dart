import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopupErrorWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool showActions;

  const PopupErrorWidget({
    super.key,
    this.title = 'Ops... Um erro ocorreu',
    required this.content,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
      actions: [
        TextButton(
          onPressed: () => Clipboard.setData(ClipboardData(text: content)),
          style: TextButton.styleFrom(
            textStyle: const TextStyle(decoration: TextDecoration.none),
            backgroundColor: AppScheme.gray[2],
          ),
          child: const Text('Copiar Erro'),
        ),
      ],
    );
  }
}
