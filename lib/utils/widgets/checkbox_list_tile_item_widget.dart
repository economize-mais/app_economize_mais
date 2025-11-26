import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';

class CheckboxListTileItemWidget extends StatelessWidget {
  final bool valor;
  final String titulo;
  final void Function(bool?)? onChanged;

  const CheckboxListTileItemWidget({
    super.key,
    required this.valor,
    required this.titulo,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      onChanged: onChanged ?? (_) {},
      value: valor,
      dense: true,
      visualDensity: VisualDensity.compact,
      title: Text(
        titulo,
        style: TextStyle(
          color: AppScheme.gray[4],
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      activeColor: AppScheme.brightGreen,
    );
  }
}
