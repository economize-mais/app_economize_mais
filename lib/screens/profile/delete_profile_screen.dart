import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DeleteProfileScreen extends StatefulWidget {
  const DeleteProfileScreen({super.key});

  @override
  State<DeleteProfileScreen> createState() => _DeleteProfileScreenState();
}

class _DeleteProfileScreenState extends State<DeleteProfileScreen> {
  bool isDeletingProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        title: 'Excluir Conta',
        hideActions: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Visibility(
            visible: !isDeletingProfile,
            replacement: const CustomCircularProgressIndicator(
              text: 'Excluindo conta...',
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Tem certeza de que deseja excluir sua conta?\nEssa ação é permanente e não poderá ser desfeita.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity(vertical: -2),
                  ),
                  child: const Text('Não desejo excluir'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _deleteProfile,
                  child: const Text('Sim, desejo excluir'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _deleteProfile() async {
    setState(() => isDeletingProfile = true);

    final provider = context.read<UsuarioProvider>();

    try {
      await provider.deleteProfile();
      await provider.limparCampos();
      if (!mounted) return;

      context.go('/');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => const PopupErrorWidget(
            title: 'Sucesso!',
            content: 'Conta excluída.',
          ),
        );
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
          content: provider.errorMessage,
        ),
      );
    }

    setState(() => isDeletingProfile = false);
  }
}
