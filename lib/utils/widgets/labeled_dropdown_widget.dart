import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class LabeledDropdownWidget extends StatefulWidget {
  final TextEditingController controller;
  final String value;
  final List<String> items;
  final String label;
  final void Function(String?)? onChanged;

  const LabeledDropdownWidget({
    super.key,
    required this.controller,
    required this.value,
    required this.items,
    required this.label,
    this.onChanged,
  });

  @override
  State<LabeledDropdownWidget> createState() => _LabeledDropdownWidgetState();
}

class _LabeledDropdownWidgetState extends State<LabeledDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.label),
        DropdownButtonFormField<String>(
          value: widget.value,
          isExpanded: true,
          dropdownColor: AppScheme.lightGray,
          iconEnabledColor: AppScheme.gray[4],
          decoration: const InputDecoration(
            filled: true,
            fillColor: AppScheme.lightGray,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            constraints: BoxConstraints(minHeight: 49, maxHeight: 49),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
          onChanged: widget.onChanged ??
              (newValue) => setState(() {
                    widget.controller.text = newValue!;
                  }),
          items: widget.items
              .map(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
