import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_economize_mais/screens/alertas/alertas_screen.dart';
import 'package:app_economize_mais/screens/announcement/announcement_screen.dart';
import 'package:app_economize_mais/screens/home/initial_screen.dart';
import 'package:app_economize_mais/screens/profile/profile_screen.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class HomeScreen extends StatefulWidget {
  final String type;

  const HomeScreen({super.key, required this.type});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> listaTelas;
  int currentIndex = 0;

  @override
  void initState() {
    listaTelas = [
      const InitialScreen(),
      widget.type == 'USER'
          ? const AlertasScreen()
          : const AnnouncementScreen(),
      const ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listaTelas[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => currentIndex = value),
        backgroundColor: AppScheme.brightGreen,
        selectedItemColor: AppScheme.black,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            label: 'Início',
            icon: SvgPicture.asset(
              currentIndex == 0
                  ? 'assets/icons/home-variant.svg'
                  : 'assets/icons/home-variant-outline.svg',
              height: 24,
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: widget.type == 'USER' ? 'Alertas' : 'Anúncios',
            icon: SvgPicture.asset(
              currentIndex == 1
                  ? 'assets/icons/bullhorn.svg'
                  : 'assets/icons/bullhorn-outline.svg',
              height: 24,
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: SvgPicture.asset(
              currentIndex == 2
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
}
