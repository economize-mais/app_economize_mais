import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/screens/login/widget/popup_como_conheceu_pesquisa_widget.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final bool unauthorizedAccess;
  const LoginScreen({super.key, this.unauthorizedAccess = false});

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

    _initialize();
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/logo-verde.png',
                    width: 220,
                    height: 220,
                  ),
                  Text(
                    'Entre na sua conta',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                        replacement: const CustomCircularProgressIndicator(),
                        child: FilledButton(
                          onPressed: () => login(usuarioProvider),
                          child: const Text('Entrar'),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.push('/register/recover-password'),
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    child: const Text('Recuperar Senha'),
                  ),
                  const SizedBox(height: 4),
                  const Text('Não possui uma conta?'),
                  OutlinedButton(
                    onPressed: () => context.push('/register'),
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
      ),
    );
  }

  void _initialize() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    if (widget.unauthorizedAccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) => PopupErrorWidget(
                content:
                    'O token de acesso foi expirado. Entre com sua conta novamente.'));
      });
    }
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

    await verifyComoConhece(
        usuarioProvider.userModel!.originAcceptance, usuarioProvider);

    if (!mounted) return;

    bool hasUnacceptedTerms =
        usuarioProvider.userModel!.termsAcceptance!.containsValue(false);

    context.pushReplacement(hasUnacceptedTerms ? '/terms' : '/home',
        extra: usuarioProvider.userModel!.type);
  }

  Future verifyComoConhece(
      bool originAcceptance, UsuarioProvider usuarioProvider) async {
    if (originAcceptance) return;

    final optionsList = await usuarioProvider.getOrigin();
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

    await showDialog(
      context: context,
      builder: (context) => PopupComoConheceuPesquisaWidget(
        optionsList: optionsList,
      ),
    );
  }
}
