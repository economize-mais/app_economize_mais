import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/formatters/uppercase_text_formatter.dart';
import 'package:app_economize_mais/utils/widgets/custom_list_tile_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class EnderecosScreen extends StatefulWidget {
  const EnderecosScreen({super.key});

  @override
  State<EnderecosScreen> createState() => _EnderecosScreenState();
}

class _EnderecosScreenState extends State<EnderecosScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController ufController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();

  final enderecos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        title: 'Endereços',
        hideActions: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                            mask: "#####-###", filter: {'#': RegExp(r'[0-9]')}),
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
              LabeledOutlineTextFieldWidget(
                controller: ruaController,
                label: 'Rua/Avenida/Travessia',
                paddingTop: 15,
                paddingBottom: 15,
              ),
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
              const SizedBox(height: 15),
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
              LabeledOutlineTextFieldWidget(
                controller: complementoController,
                label: 'Complemento',
                paddingTop: 15,
                paddingBottom: 25,
              ),
              FilledButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  setState(() {
                    enderecos.add(ruaController.text);
                  });
                },
                child: const Text('Salvar'),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 24,
                  ),
                  label: Text(
                    'Adicionar outro endereço',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: AppScheme.gray[4],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: enderecos.length,
                itemBuilder: (context, index) => CustomListTileWidget(
                  label: enderecos[index],
                  trailingRow: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_outlined,
                        color: AppScheme.gray[4],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() => enderecos.removeAt(index));
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppScheme.gray[4],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
