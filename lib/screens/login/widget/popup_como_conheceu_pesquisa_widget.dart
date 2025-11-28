import 'package:app_economize_mais/models/origin_model.dart';
import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PopupComoConheceuPesquisaWidget extends StatefulWidget {
  final List<OriginModel> optionsList;
  const PopupComoConheceuPesquisaWidget({super.key, required this.optionsList});

  @override
  State<PopupComoConheceuPesquisaWidget> createState() =>
      _PopupComoConheceuPesquisaWidgetState();
}

class _PopupComoConheceuPesquisaWidgetState
    extends State<PopupComoConheceuPesquisaWidget> {
  bool carregando = false;

  bool _selecionarOpcao = false;
  int? _idPesquisa;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppScheme.white,
      elevation: 2,
      shadowColor: AppScheme.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: AppScheme.lightGray),
      ),
      iconPadding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      icon: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.close, size: 20),
        ),
      ),
      title: Text(
        'Opa, é rapidinho',
        style: TextStyle(
          color: AppScheme.gray[4],
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Conta pra gente, como ficou sabendo do aplicativo?',
            style: TextStyle(
              color: AppScheme.gray[4],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          ...widget.optionsList.map(
            (item) => RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.description),
              value: item.id,
              groupValue: _idPesquisa,
              onChanged: (value) => setState(() => _idPesquisa = value),
            ),
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: _selecionarOpcao,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Selecione uma opção',
                style: TextStyle(color: AppScheme.red),
              ),
            ),
          ),
          Visibility(
            visible: !carregando,
            replacement: const CustomCircularProgressIndicator(),
            child: FilledButton(
              onPressed: () async => await _onPressed(),
              child: const Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }

  Future _onPressed() async {
    if (_idPesquisa == null) {
      setState(() => _selecionarOpcao = true);
      return;
    }
    setState(() => carregando = true);

    final UsuarioProvider usuarioProvider = Provider.of(context, listen: false);
    await usuarioProvider.postOrigin(_idPesquisa!);

    setState(() => carregando = false);

    if (!mounted) return;

    if (usuarioProvider.hasError) {
      showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
          content: usuarioProvider.errorMessage,
        ),
      );
      return;
    }

    context.pop();
  }
}
