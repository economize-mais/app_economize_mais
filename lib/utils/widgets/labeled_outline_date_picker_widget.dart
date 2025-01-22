import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class LabeledOutlineDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const LabeledOutlineDatePicker({
    super.key,
    required this.controller,
    this.label = 'Data de Nascimento',
  });

  @override
  State<LabeledOutlineDatePicker> createState() =>
      _LabeledOutlineDatePickerState();
}

class _LabeledOutlineDatePickerState extends State<LabeledOutlineDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: AppScheme.gray[4],
            fontSize: 12,
          ),
        ),
        TextFormField(
          onTap: () => showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ).then(
            (value) => setState(() {
              if (value == null) return;

              final formatter = DateFormat('dd/MM/yyyy');
              widget.controller.text = formatter.format(value);
            }),
          ),
          controller: widget.controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            filled: true,
            fillColor: AppScheme.lightGray,
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          style: TextStyle(
            color: AppScheme.gray[3],
            fontSize: 12,
          ),
          inputFormatters: [
            MaskTextInputFormatter(
                mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')})
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Este campo precisa ser preenchido';
            }

            return null;
          },
        ),
      ],
    );
  }
}
