import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

final kRoundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(5),
  side: BorderSide(color: AppScheme.gray[1]!),
);

class CustomExpansionTileWidget extends StatelessWidget {
  final String title;
  final List<Widget>? children;
  final double paddingBottom;

  const CustomExpansionTileWidget({
    super.key,
    required this.title,
    required this.children,
    this.paddingBottom = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: ExpansionTile(
        dense: true,
        shape: kRoundedRectangleBorder,
        collapsedShape: kRoundedRectangleBorder,
        tilePadding: const EdgeInsets.symmetric(horizontal: 20),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: Text(
          title,
          style: TextStyle(
            color: AppScheme.gray[4],
            fontSize: 12,
          ),
        ),
        children: children ?? [],
      ),
    );
  }
}
