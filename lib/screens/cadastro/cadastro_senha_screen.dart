import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/screens/cadastro/widgets/condicoes_senhas_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroSenhaScreen extends StatefulWidget {
  final Map<String, dynamic> userJson;

  const CadastroSenhaScreen({
    super.key,
    required this.userJson,
  });

  @override
  State<CadastroSenhaScreen> createState() => _CadastroSenhaScreenState();
}

class _CadastroSenhaScreenState extends State<CadastroSenhaScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController senhaController;
  late TextEditingController confirmaSenhaController;

  bool cumpreCondicoesSenha = false;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    senhaController = TextEditingController();
    confirmaSenhaController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Defina sua senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppScheme.gray[4],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LabeledOutlineTextFieldWidget(
                    controller: senhaController,
                    label: 'Senha',
                    isPassword: true,
                    paddingTop: 15,
                  ),
                  LabeledOutlineTextFieldWidget(
                    controller: confirmaSenhaController,
                    label: 'Confirmar Senha',
                    isPassword: true,
                    paddingTop: 15,
                    paddingBottom: 15,
                  ),
                  ListenableBuilder(
                    listenable: senhaController,
                    builder: (context, child) => CondicoesSenhasWidget(
                      controller: senhaController,
                      cumpreCondicoes: (valor) =>
                          setState(() => cumpreCondicoesSenha = valor),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Consumer<UsuarioProvider>(
                    builder: (context, usuarioProvider, child) => Visibility(
                      visible: !usuarioProvider.isLoading,
                      replacement: const Center(
                          child: CustomCircularProgressIndicator()),
                      child: FilledButton(
                        onPressed: () => cadastrar(usuarioProvider),
                        child: const Text('Cadastrar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future cadastrar(UsuarioProvider usuarioProvider) async {
    if (!formKey.currentState!.validate()) return;

    if (!cumpreCondicoesSenha) {
      showDialog(
        context: context,
        builder: (context) => const PopupErrorWidget(
          title: 'Atenção',
          content: 'A senha precisa cumprir com as condições.',
        ),
      );
      return;
    }

    final userJson = {
      ...widget.userJson,
      'password': confirmaSenhaController.text,
      'type': 'USER'
    };

    await usuarioProvider.cadastrarUsuario(userJson);

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

    showDialog(
      context: context,
      builder: (context) => const PopupErrorWidget(
        title: 'Usuário cadastrado!',
        content: '',
      ),
    ).then((_) => Navigator.popUntil(context, (route) => route.isFirst));
  }
}
