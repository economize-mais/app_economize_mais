import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  final DateTime dataMinima = DateTime(1900);
  final DateTime dataMaxima = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.label),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            filled: true,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            constraints: BoxConstraints(minHeight: 49, maxHeight: 49),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
          inputFormatters: [
            MaskTextInputFormatter(
                mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')})
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Este campo precisa ser preenchido';
            }

            return _validarData(value);
          },
        ),
      ],
    );
  }

  String? _validarData(String value) {
    try {
      final formatter = DateFormat('dd/MM/yyyy');
      final dataFormatada = formatter.parseStrict(value);

      if (dataFormatada.isBefore(dataMinima)) {
        return 'Menor que ${formatter.format(dataMinima)}';
      }
      if (dataFormatada.isAfter(dataMaxima)) {
        return 'Maior que ${formatter.format(dataMaxima)}';
      }

      return null;
    } catch (e) {
      return 'Data inválida';
    }
  }
}
