import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class ContatoSuporteScreen extends StatelessWidget {
  const ContatoSuporteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController assuntoController = TextEditingController();
    final TextEditingController mensagemController = TextEditingController();

    return Scaffold(
      appBar: const GeneralAppBar(
        title: 'Contato e Suporte',
        hideActions: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LabeledOutlineTextFieldWidget(
                controller: assuntoController,
                label: 'Assunto',
                paddingBottom: 15,
              ),
              LabeledOutlineTextFieldWidget(
                controller: mensagemController,
                label: 'Mensagem',
                maxLines: 5,
                paddingBottom: 25,
              ),
              FilledButton(
                onPressed: () {},
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
