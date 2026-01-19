import 'package:app_economize_mais/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LabeledOutlineDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Color? fillColor;
  final bool canPassMaxDate;
  final bool canBePreviousDate;

  const LabeledOutlineDatePicker({
    super.key,
    required this.controller,
    this.label = 'Data de Nascimento',
    this.fillColor,
    this.canPassMaxDate = false,
    this.canBePreviousDate = true,
  });

  @override
  State<LabeledOutlineDatePicker> createState() =>
      _LabeledOutlineDatePickerState();
}

class _LabeledOutlineDatePickerState extends State<LabeledOutlineDatePicker> {
  final DateTime dataMinima = DateTime(1900);
  final DateTime dataMaxima = DateTime.now().dateOnly;

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
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            constraints: BoxConstraints(minHeight: 49, maxHeight: 49),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
          inputFormatters: [
            MaskTextInputFormatter(
                mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')})
          ],
          validator: _validarData,
        ),
      ],
    );
  }

  String? _validarData(String? value) {
    try {
      if (value == null || value.trim().isEmpty) {
        return 'Este campo precisa ser preenchido';
      }

      final formatter = DateFormat('dd/MM/yyyy');
      final dataFormatada = formatter.parseStrict(value);

      if (dataFormatada.isBefore(dataMinima)) {
        return 'Menor que ${formatter.format(dataMinima)}';
      }

      if (!widget.canBePreviousDate && dataFormatada.isBefore(dataMaxima)) {
        return 'Menor que data atual (${formatter.format(dataMaxima)})';
      }

      if (!widget.canPassMaxDate && dataFormatada.isAfter(dataMaxima)) {
        return 'Maior que ${formatter.format(dataMaxima)}';
      }

      return null;
    } catch (e) {
      return 'Data inválida';
    }
  }
}
