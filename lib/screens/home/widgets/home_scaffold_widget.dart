import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
        onTap: _onTap,
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
            label: usuarioProvider.userModel!.type == 'USER'
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

  void _onTap(int i) {
    navigationShell.goBranch(i);
  }
}
