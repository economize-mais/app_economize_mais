import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class DadosEmpresaScreen extends StatelessWidget {
  const DadosEmpresaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController razaoSocialController =
        TextEditingController(text: 'Supermercado Alvorada Ltda');
    final TextEditingController nomeFantasiaController =
        TextEditingController(text: 'Supermercados Alvorada');
    final TextEditingController cnpjController =
        TextEditingController(text: '00.000.000/0001-00');
    final TextEditingController telefoneController =
        TextEditingController(text: '(35) 9 9999-9999');

    return Scaffold(
      appBar: const GeneralAppBar(
        title: 'Dados da empresa',
        hideActions: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LabeledOutlineTextFieldWidget(
              controller: razaoSocialController,
              label: 'Razão Social',
            ),
            const SizedBox(height: 15),
            LabeledOutlineTextFieldWidget(
              controller: nomeFantasiaController,
              label: 'Nome Fantasia',
            ),
            const SizedBox(height: 15),
            LabeledOutlineTextFieldWidget(
              controller: cnpjController,
              label: 'CNPJ',
            ),
            const SizedBox(height: 15),
            LabeledOutlineTextFieldWidget(
              controller: telefoneController,
              label: 'Telefone',
            ),
            const SizedBox(height: 25),
            FilledButton(
              onPressed: () {},
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
