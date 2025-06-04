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
    emailController =
        TextEditingController(text: 'marcus.miguel.dev@gmail.com');
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
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
              children: [
                Text(
                  'Recuperar senha',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppScheme.gray[4],
                    fontSize: 14,
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
      ),
    );
  }

  void recurarSenha() {
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
        title: const Text('Nova senha enviada por e-mail.'),
        titlePadding: const EdgeInsets.fromLTRB(40, 0, 40, 30),
      ),
    ).then((_) => Navigator.popUntil(
          context,
          (route) => route.isFirst,
        ));
  }
}
