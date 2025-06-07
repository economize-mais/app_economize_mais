import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class LabeledOutlineTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
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
    this.isPassword = false,
    this.inputFormatters,
    this.keyboardType = TextInputType.emailAddress,
    this.fillColor = AppScheme.lightGray,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.maxLines = 1,
  });

  @override
  State<LabeledOutlineTextFieldWidget> createState() =>
      _LabeledOutlineTextFieldWidgetState();
}

class _LabeledOutlineTextFieldWidgetState
    extends State<LabeledOutlineTextFieldWidget> {
  late bool obscureText = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label),
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              filled: true,
              // fillColor: widget.fillColor,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () => setState(() => obscureText = !obscureText),
                      child: Icon(
                        !obscureText ? Icons.visibility : Icons.visibility_off,
                        color: AppScheme.gray[3],
                      ),
                    )
                  : null,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            obscureText: obscureText,
            inputFormatters: widget.inputFormatters,
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
