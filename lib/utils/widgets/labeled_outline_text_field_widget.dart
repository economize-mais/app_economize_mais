import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class LabeledOutlineTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final Color fillColor;
  final double paddingTop;
  final double paddingBottom;
  final int maxLines;

  const LabeledOutlineTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType = TextInputType.emailAddress,
    this.fillColor = AppScheme.lightGray,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppScheme.gray[4],
              fontSize: 12,
            ),
          ),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            style: TextStyle(
              color: AppScheme.gray[3],
              fontSize: 12,
            ),
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Este campo precisa ser preenchido';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
