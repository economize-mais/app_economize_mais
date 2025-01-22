import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

final kBorderRadius = BorderRadius.circular(5);

class CustomListTileWidget extends StatelessWidget {
  final String label;
  final List<Widget> trailingRow;

  const CustomListTileWidget({
    super.key,
    required this.label,
    required this.trailingRow,
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
          label,
          style: TextStyle(
            color: AppScheme.gray[4],
            fontSize: 12,
          ),
        ),
        trailing: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: trailingRow.length,
          itemBuilder: (context, index) => trailingRow[index],
        ),
      ),
    );
  }
}
