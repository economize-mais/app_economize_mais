import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/formatters/uppercase_text_formatter.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

// TODO: adicionar funcionalidade de geolocalização e botões para ler e aceitar termos e condições assim como politicas de privacidade
class CadastroEnderecoScreen extends StatelessWidget {
  const CadastroEnderecoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController cepController =
        TextEditingController(text: '37130-079');
    final TextEditingController ruaController =
        TextEditingController(text: 'Rua');
    final TextEditingController numeroController =
        TextEditingController(text: '079');
    final TextEditingController bairroController =
        TextEditingController(text: 'Bairro');
    final TextEditingController cidadeController =
        TextEditingController(text: 'Alfenas');
    final TextEditingController ufController =
        TextEditingController(text: 'MG');
    final TextEditingController complementoController =
        TextEditingController(text: 'Casa');

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
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
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                    child: const Text('Cadastrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
