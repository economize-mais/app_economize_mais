import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';

enum ComoConheceuPesquisa {
  amigoFamiliar,
  redesSociais,
  lojasParceiras,
  outdoor,
  outro,
}

class PopupComoConheceuPesquisaWidget extends StatefulWidget {
  const PopupComoConheceuPesquisaWidget({super.key});

  @override
  State<PopupComoConheceuPesquisaWidget> createState() =>
      _PopupComoConheceuPesquisaWidgetState();
}

class _PopupComoConheceuPesquisaWidgetState
    extends State<PopupComoConheceuPesquisaWidget> {
  bool _selecionarOpcao = false;
  ComoConheceuPesquisa? _pesquisa;

  final List<Map<String, dynamic>> _opcoesPesquisa = [
    {
      'title': 'Indicação de um amigo ou familiar',
      'value': ComoConheceuPesquisa.amigoFamiliar
    },
    {
      'title': 'Vi nas redes sociais',
      'value': ComoConheceuPesquisa.redesSociais
    },
    {
      'title': 'Vi nas lojas parceiras',
      'value': ComoConheceuPesquisa.lojasParceiras
    },
    {
      'title': 'Vi em um Outdoor',
      'value': ComoConheceuPesquisa.outdoor,
    },
    {
      'title': 'Outro',
      'value': ComoConheceuPesquisa.outro,
    },
  ];

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
          onTap: () => Navigator.pop(context),
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
          ..._opcoesPesquisa.map(
            (opcao) => RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(opcao['title']),
              value: opcao['value'],
              groupValue: _pesquisa,
              onChanged: (value) => setState(() {
                _pesquisa = value;
              }),
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
          FilledButton(
            onPressed: () {
              if (_pesquisa == null) {
                setState(() => _selecionarOpcao = true);
                return;
              }

              Navigator.pop(context);
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
