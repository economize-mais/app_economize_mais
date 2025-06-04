import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/formatters/uppercase_text_formatter.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

// TODO: adicionar funcionalidade de geolocalização e botões para ler e aceitar termos e condições assim como politicas de privacidade
class CadastroEnderecoScreen extends StatefulWidget {
  final Map<String, dynamic> userJson;

  const CadastroEnderecoScreen({
    super.key,
    required this.userJson,
  });

  @override
  State<CadastroEnderecoScreen> createState() => _CadastroEnderecoScreenState();
}

class _CadastroEnderecoScreenState extends State<CadastroEnderecoScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController cepController;
  late TextEditingController ruaController;
  late TextEditingController numeroController;
  late TextEditingController bairroController;
  late TextEditingController cidadeController;
  late TextEditingController ufController;
  late TextEditingController complementoController;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    cepController = TextEditingController(text: '37130-079');
    ruaController = TextEditingController(text: 'Rua');
    numeroController = TextEditingController(text: '079');
    bairroController = TextEditingController(text: 'Bairro');
    cidadeController = TextEditingController(text: 'Alfenas');
    ufController = TextEditingController(text: 'MG');
    complementoController = TextEditingController(text: 'Casa');
  }

  @override
  void dispose() {
    super.dispose();

    cepController.dispose();
    ruaController.dispose();
    numeroController.dispose();
    bairroController.dispose();
    cidadeController.dispose();
    ufController.dispose();
    complementoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Adicione seu endereço para criar a sua conta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppScheme.gray[4],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: LabeledOutlineTextFieldWidget(
                        controller: cepController,
                        label: 'CEP',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(
                              mask: "#####-###",
                              filter: {'#': RegExp(r'[0-9]')}),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      icon: const Icon(Icons.help_outline_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                LabeledOutlineTextFieldWidget(
                  controller: ruaController,
                  label: 'Rua/Avenida/Travessia',
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: LabeledOutlineTextFieldWidget(
                        controller: numeroController,
                        label: 'Número',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: LabeledOutlineTextFieldWidget(
                        controller: bairroController,
                        label: 'Bairro',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: LabeledOutlineTextFieldWidget(
                        controller: cidadeController,
                        label: 'Cidade',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: LabeledOutlineTextFieldWidget(
                        controller: ufController,
                        label: 'UF',
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                          MaskTextInputFormatter(
                            mask: '##',
                            filter: {
                              '#': RegExp(r'[A-Z]'),
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                LabeledOutlineTextFieldWidget(
                  controller: complementoController,
                  label: 'Complemento',
                ),
                const SizedBox(height: 25),
                FilledButton(
                  onPressed: continuar,
                  child: const Text('Continuar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void continuar() {
    if (!formKey.currentState!.validate()) return;
    ruaController.text = ruaController.text.trim();
    bairroController.text = bairroController.text.trim();
    cidadeController.text = cidadeController.text.trim();
    ufController.text = ufController.text.trim();
    complementoController.text = complementoController.text.trim();

    final userJson = {
      ...widget.userJson,
      'addresses': [
        {
          'street': ruaController.text,
          'number': numeroController.text,
          'neighborhood': bairroController.text,
          'city': cidadeController.text,
          'state': ufController.text,
          'complement': complementoController.text,
          'zipcode': cepController.text,
        },
      ],
    };

    // Navigator.popUntil(
    //   context,
    //   (route) => route.isFirst,
    // );
  }
}
