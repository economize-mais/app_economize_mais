import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class TrocarSenhaScreen extends StatelessWidget {
  const TrocarSenhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController senhaController =
        TextEditingController(text: '12345678');
    final TextEditingController novaSenhaController =
        TextEditingController(text: '12345678');
    final TextEditingController confirmarNovaSenhaController =
        TextEditingController(text: '12345678');

    return Scaffold(
      appBar: const GeneralAppBar(
        title: 'Trocar Senha',
        hideActions: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LabeledOutlineTextFieldWidget(
                controller: senhaController,
                label: 'Senha',
                obscureText: true,
                paddingBottom: 15,
              ),
              LabeledOutlineTextFieldWidget(
                controller: novaSenhaController,
                label: 'Nova Senha',
                obscureText: true,
                paddingBottom: 15,
              ),
              LabeledOutlineTextFieldWidget(
                controller: confirmarNovaSenhaController,
                label: 'Confirmar Nova Senha',
                obscureText: true,
                paddingBottom: 25,
              ),
              FilledButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  showDialog(
                    context: context,
                    barrierColor: AppScheme.white.withOpacity(0.7),
                    builder: (context) => AlertDialog(
                      backgroundColor: AppScheme.white,
                      elevation: 2,
                      shadowColor: AppScheme.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: AppScheme.lightGray),
                      ),
                      icon: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, size: 20),
                        ),
                      ),
                      iconPadding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      title: const Text('Senha alterada com sucesso!'),
                      titlePadding: const EdgeInsets.fromLTRB(40, 0, 40, 30),
                    ),
                  );
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
