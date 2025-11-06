import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

String? cpfFormatter(String? text, bool isCPF) {
  if (text == null) {
    return text;
  }

  String maskedText = text;

  final mask = MaskTextInputFormatter(
    mask: isCPF ? "###.###.###-##" : "##.###.###/####-##",
    filter: {"#": RegExp(r'[0-9]')},
  );

  maskedText = mask.maskText(text);

  return maskedText;
}

String? phoneFormatter(String? text) {
  if (text == null) {
    return text;
  }

  String maskedText = text;

  final mask = MaskTextInputFormatter(
    mask: "(##) # ####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  maskedText = mask.maskText(text);

  return maskedText;
}
