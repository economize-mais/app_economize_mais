import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/profile/widgets/profile_widget.dart';
import 'package:app_economize_mais/utils/widgets/custom_elevated_button_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        applyLeading: false,
        title: 'Perfil',
        hideActions: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfileWidget(),
            CustomElevatedButtonWidget(
              onPressed: () => Navigator.pushNamed(context, '/dados-empresa'),
              title: 'Dados da Empresa',
            ),
            CustomElevatedButtonWidget(
              onPressed: () => Navigator.pushNamed(context, '/enderecos'),
              title: 'Endereços',
            ),
            CustomElevatedButtonWidget(
              onPressed: () => Navigator.pushNamed(context, '/trocar-senha'),
              title: 'Trocar Senha',
            ),
            CustomElevatedButtonWidget(
              onPressed: () =>
                  Navigator.pushNamed(context, '/perguntas-frequentes'),
              title: 'Perguntas Frequentes',
            ),
            CustomElevatedButtonWidget(
              onPressed: () {},
              title: 'Termos de Uso',
            ),
            CustomElevatedButtonWidget(
              onPressed: () {},
              title: 'Políticas de Privacidade',
            ),
            CustomElevatedButtonWidget(
              onPressed: () => Navigator.pushNamed(context, '/contato-suporte'),
              title: 'Contato e Suporte',
            ),
            CustomElevatedButtonWidget(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                ModalRoute.withName('/'),
              ),
              title: 'Sair do aplicativo',
              iconData: Icons.logout,
              iconSize: 24,
            ),
          ],
        ),
      ),
    );
  }
}
