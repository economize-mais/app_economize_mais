import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/widgets.dart';

class MeasurementUnitsWidget extends StatelessWidget {
  final int selectedUnitIndex;
  final List<String> units;
  final void Function(int value) onSelected;

  const MeasurementUnitsWidget(
      {super.key,
      required this.selectedUnitIndex,
      required this.units,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: units.map((unit) {
        final int unitIndex = units.indexOf(unit);
        final double leftRadius = unitIndex == 0 ? 8 : 0;
        final double rightRadius = unitIndex == units.length - 1 ? 8 : 0;

        return Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: selectedUnitIndex == unitIndex
                ? AppScheme.brightGreen
                : AppScheme.lightGray,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(leftRadius),
              bottomLeft: Radius.circular(leftRadius),
              topRight: Radius.circular(rightRadius),
              bottomRight: Radius.circular(rightRadius),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              if (selectedUnitIndex == unitIndex) return;

              onSelected(unitIndex);
            },
            child: Text(
              unit,
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }
}
