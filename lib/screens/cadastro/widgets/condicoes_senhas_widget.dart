import 'package:app_economize_mais/utils/widgets/checkbox_list_tile_item_widget.dart';
import 'package:flutter/material.dart';

class CondicoesSenhasWidget extends StatefulWidget {
  final TextEditingController controller;
  final void Function(bool)? cumpreCondicoes;

  const CondicoesSenhasWidget({
    super.key,
    required this.controller,
    this.cumpreCondicoes,
  });

  @override
  State<CondicoesSenhasWidget> createState() => _CondicoesSenhasWidgetState();
}

class _CondicoesSenhasWidgetState extends State<CondicoesSenhasWidget> {
  bool tamanhoSenha = false;
  bool temCaracterEspecial = false;
  bool temNumero = false;

  void verifyPassword() {
    final text = widget.controller.text;

    setState(() {
      tamanhoSenha = text.length >= 8 && text.length <= 25;
      temCaracterEspecial = text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      temNumero = text.contains(RegExp(r'[0-9]'));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.cumpreCondicoes
          ?.call(tamanhoSenha && temCaracterEspecial && temNumero);
    });
  }

  @override
  void didUpdateWidget(covariant CondicoesSenhasWidget oldWidget) {
    verifyPassword();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CheckboxListTileItemWidget(
          valor: tamanhoSenha,
          titulo: 'Ter no mínimo 8 dígitos',
        ),
        CheckboxListTileItemWidget(
          valor: temCaracterEspecial,
          titulo: 'Conter pelo menos um caractere especial (@#\$!...)',
        ),
        CheckboxListTileItemWidget(
          valor: temNumero,
          titulo: 'Conter pelos menos um número',
        ),
      ],
    );
  }
}
