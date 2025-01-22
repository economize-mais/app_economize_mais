import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

final kBorderRadius = BorderRadius.circular(5);

class AlertaListTileWidget extends StatelessWidget {
  final String alerta;
  final void Function()? onDelete;

  const AlertaListTileWidget({
    super.key,
    required this.alerta,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: AppScheme.black,
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      clipBehavior: Clip.none,
      child: ListTile(
        dense: true,
        tileColor: AppScheme.white,
        visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
        contentPadding: const EdgeInsets.only(
          left: 20,
          top: 10,
          right: 10,
          bottom: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
          side: BorderSide(
            color: AppScheme.gray[1]!,
          ),
        ),
        title: Text(
          alerta,
          style: TextStyle(
            color: AppScheme.gray[4],
            fontSize: 12,
          ),
        ),
        trailing: GestureDetector(
          onTap: onDelete,
          child: const Icon(
            Icons.delete_outline,
            size: 24,
          ),
        ),
      ),
    );
  }
}
