import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';

class CustomAutocompleteWidget extends StatelessWidget {
  final String label;
  final List<String> possibleOptions;
  final void Function(String)? onSelected;
  final Color fillColor;
  final TextEditingValue? initialValue;

  const CustomAutocompleteWidget({
    super.key,
    required this.label,
    required this.possibleOptions,
    required this.onSelected,
    this.fillColor = AppScheme.lightGray,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Autocomplete<String>(
          fieldViewBuilder: _fieldViewBuilder,
          optionsViewBuilder: _optionsViewBuilder,
          initialValue: initialValue,
          onSelected: onSelected,
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text == '') {
              return possibleOptions;
            }

            final lowerCaseText = textEditingValue.text.toLowerCase();

            return possibleOptions.where(
                (option) => option.toLowerCase().contains(lowerCaseText));
          },
        ),
      ],
    );
  }

  Widget _fieldViewBuilder(
          BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          void Function() onFieldSubmitted) =>
      TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        onTapOutside: (_) {
          focusNode.unfocus();
          if (onSelected != null) {
            onSelected!(textEditingController.text);
          }
        },
        onFieldSubmitted: (value) {
          if (onSelected != null) {
            onSelected!(textEditingController.text);
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  Widget _optionsViewBuilder(BuildContext context,
          void Function(String) onSelected, Iterable<String> options) =>
      ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: options.length,
        itemBuilder: (context, i) {
          final String option = options.elementAt(i);

          return InkWell(
            key: GlobalObjectKey(option),
            onTap: () => onSelected(option),
            child: Builder(
              builder: (context) => Container(
                color: fillColor,
                padding: const EdgeInsets.all(16.0),
                child: Text(RawAutocomplete.defaultStringForOption(option)),
              ),
            ),
          );
        },
      );
}
