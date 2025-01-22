import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/login/widget/criar_conta_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController =
        TextEditingController(text: 'email@email.com');
    final TextEditingController passwordController =
        TextEditingController(text: '123456');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 220,
                  maxHeight: 150,
                ),
                child: Image.asset(
                  'assets/icons/logo-verde.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Text(
                'Entre na sua conta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppScheme.gray[4],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: LabeledOutlineTextFieldWidget(
                  controller: emailController,
                  label: 'E-mail',
                ),
              ),
              LabeledOutlineTextFieldWidget(
                controller: passwordController,
                label: 'Senha',
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 15),
                child: FilledButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;

                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Entrar'),
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/cadastro/recuperar-senha'),
                style: TextButton.styleFrom(
                  visualDensity: const VisualDensity(vertical: -3),
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text('Recuperar Senha'),
              ),
              const SizedBox(height: 4),
              const CriarContaWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
