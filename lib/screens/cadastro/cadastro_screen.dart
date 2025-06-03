import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_economize_mais/models/usuario_model.dart';
import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/labeled_dropdown_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_date_picker_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';
import 'package:app_economize_mais/utils/widgets/text_button_with_icon_widget.dart';
import 'package:provider/provider.dart';

class CadastroScreen extends StatelessWidget {
  const CadastroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nomeCompletoController =
        TextEditingController(text: 'Iago Engel Serafin');
    final TextEditingController cpfController =
        TextEditingController(text: '123.456.789-00');
    final TextEditingController telefoneController =
        TextEditingController(text: '(35) 9 9999-9999');
    final TextEditingController emailController =
        TextEditingController(text: 'example@example.com');
    final TextEditingController dataNascimentoController =
        TextEditingController(text: '17/12/1998');
    final TextEditingController generoController =
        TextEditingController(text: 'Feminino');

    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tela de cadastro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppScheme.gray[4],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              LabeledOutlineTextFieldWidget(
                controller: nomeCompletoController,
                label: 'Nome Completo',
                paddingTop: 15,
              ),
              LabeledOutlineTextFieldWidget(
                controller: cpfController,
                label: 'CPF',
                paddingTop: 15,
                inputFormatters: [
                  MaskTextInputFormatter(
                      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')})
                ],
                keyboardType: TextInputType.number,
              ),
              LabeledOutlineTextFieldWidget(
                controller: telefoneController,
                label: 'Telefone',
                paddingTop: 15,
                inputFormatters: [
                  MaskTextInputFormatter(
                      mask: "(##) # ####-####", filter: {"#": RegExp(r'[0-9]')})
                ],
                keyboardType: TextInputType.number,
              ),
              LabeledOutlineTextFieldWidget(
                controller: emailController,
                label: 'Email',
                paddingTop: 15,
                paddingBottom: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: LabeledOutlineDatePicker(
                      controller: dataNascimentoController,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: LabeledDropdownWidget(
                      controller: generoController,
                      value: generoController.text.isEmpty
                          ? 'Feminino'
                          : generoController.text,
                      items: const ['Feminino', 'Masculino', 'Outro'],
                      label: 'Gênero',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButtonWithIconWidget(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    nomeCompletoController.text =
                        nomeCompletoController.text.trim();

                    Provider.of<UsuarioProvider>(context, listen: false)
                        .usuarioModel = UsuarioModel(
                      nomeCompletoController.text,
                      cpfController.text,
                      telefoneController.text,
                      dataNascimentoController.text,
                      generoController.text,
                    );

                    Navigator.pushNamed(context, '/cadastro/endereco');
                  },
                  label: 'Adicionar Endereço',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
