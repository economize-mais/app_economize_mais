import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    emailController =
        TextEditingController(text: 'marcus.miguel.dev@gmail.com');
    passwordController = TextEditingController(text: 'Mudar@123');
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                LabeledOutlineTextFieldWidget(
                  controller: emailController,
                  label: 'E-mail',
                  paddingTop: 15,
                  paddingBottom: 10,
                ),
                LabeledOutlineTextFieldWidget(
                  controller: passwordController,
                  label: 'Senha',
                  isPassword: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 15),
                  child: Consumer<UsuarioProvider>(
                    builder: (context, usuarioProvider, child) => Visibility(
                      visible: !usuarioProvider.isLoading,
                      replacement: const CircularProgressIndicator(),
                      child: FilledButton(
                        onPressed: () => login(usuarioProvider),
                        child: const Text('Entrar'),
                      ),
                    ),
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
                const Text(
                  'Não possui uma conta?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/cadastro'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                  child: const Text('Criar nova conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login(UsuarioProvider usuarioProvider) async {
    if (!formKey.currentState!.validate()) return;

    await usuarioProvider.login(emailController.text, passwordController.text);

    if (!mounted) return;

    if (usuarioProvider.hasError) {
      showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
          content: usuarioProvider.errorMessage,
        ),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, '/home');
  }
}
