import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class EnderecoUnidadeWidget extends StatelessWidget {
  final String unidade;
  final String endereco;
  final double fontSize;

  const EnderecoUnidadeWidget({
    super.key,
    required this.unidade,
    required this.endereco,
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: unidade,
        style: TextStyle(
          color: AppScheme.gray[4],
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(text: ' - $endereco'),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
