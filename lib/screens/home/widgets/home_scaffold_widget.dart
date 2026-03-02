import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/widgets/popup_error_widget.dart';

class HomeScaffoldWidget extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScaffoldWidget({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final UsuarioProvider usuarioProvider = Provider.of(context, listen: false);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppScheme.brightGreen,
        selectedItemColor: AppScheme.black,
        currentIndex: navigationShell.currentIndex,
        onTap: (i) async => await _onTap(i, context),
        items: [
          BottomNavigationBarItem(
            label: 'Início',
            icon: SvgPicture.asset(
              navigationShell.currentIndex == 0
                  ? 'assets/icons/home-variant.svg'
                  : 'assets/icons/home-variant-outline.svg',
              height: 24,
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: (usuarioProvider.userModel == null ||
                    usuarioProvider.userModel!.type == 'USER')
                ? 'Alertas'
                : 'Anúncios',
            icon: SvgPicture.asset(
              navigationShell.currentIndex == 1
                  ? 'assets/icons/bullhorn.svg'
                  : 'assets/icons/bullhorn-outline.svg',
              height: 24,
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: SvgPicture.asset(
              navigationShell.currentIndex == 2
                  ? 'assets/icons/account.svg'
                  : 'assets/icons/account-outline.svg',
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTap(int i, BuildContext context) async {
    final provider = context.read<UsuarioProvider>();
    final loggedIn = await provider.hasSavedCredentials();

    if (!context.mounted) return;

    if (i > 0 && !loggedIn) {
      showDialog(
        context: context,
        builder: (_) => PopupErrorWidget(
          content: 'Para acessar este conteúdo, conecte-se à uma conta.',
        ),
      );

      return;
    }

    navigationShell.goBranch(i);
  }
}
