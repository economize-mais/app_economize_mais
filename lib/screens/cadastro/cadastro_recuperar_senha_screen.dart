import 'package:app_economize_mais/utils/widgets/common_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class CadastroRecuperarSenhaScreen extends StatefulWidget {
  const CadastroRecuperarSenhaScreen({super.key});

  @override
  State<CadastroRecuperarSenhaScreen> createState() =>
      _CadastroRecuperarSenhaScreenState();
}

class _CadastroRecuperarSenhaScreenState
    extends State<CadastroRecuperarSenhaScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Recuperar senha',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 15),
              LabeledOutlineTextFieldWidget(
                controller: emailController,
                label: 'Insira seu e-mail para recuperar a sua senha',
              ),
              const SizedBox(height: 25),
              FilledButton(
                onPressed: recurarSenha,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void recurarSenha() {
    if (!formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      barrierColor: AppScheme.white.withOpacity(0.7),
      builder: (context) => const CommonPopupWidget(),
    ).then((_) => Navigator.popUntil(
          context,
          (route) => route.isFirst,
        ));
  }
}
