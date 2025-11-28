import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/profile/widgets/profile_widget.dart';
import 'package:app_economize_mais/utils/widgets/custom_elevated_button_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UsuarioProvider usuarioProvider;
  late bool isUser;

  @override
  void initState() {
    super.initState();

    usuarioProvider = Provider.of(context, listen: false);
    final userModel = usuarioProvider.userModel!;
    isUser = userModel.type == 'USER';
  }

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
            Consumer<UsuarioProvider>(
              builder: (context, usuarioProviderAux, child) {
                final name = isUser
                    ? usuarioProviderAux.userModel!.name
                    : usuarioProviderAux.userModel!.companyName!;

                return ProfileWidget(
                  name: name!,
                );
              },
            ),
            CustomElevatedButtonWidget(
              onPressed: () => context.push('/profile/profile-data'),
              title: 'Dados ${isUser ? 'Pessoais' : 'da Empresa'} ',
            ),
            // CustomElevatedButtonWidget(
            //   onPressed: () => context.push('/profile/addresses'),
            //   title: 'Endereços',
            // ),
            CustomElevatedButtonWidget(
              onPressed: () => context.push('/profile/change-password'),
              title: 'Trocar Senha',
            ),
            CustomElevatedButtonWidget(
              onPressed: () => context.push('/profile/common-questions'),
              title: 'Perguntas Frequentes',
            ),
            CustomElevatedButtonWidget(
              onPressed: () => context.push('/advertise-with-us'),
              title: 'Anuncie com a gente',
            ),
            CustomElevatedButtonWidget(
              onPressed: () =>
                  context.push('/profile/terms/single', extra: 'USAGE'),
              title: 'Termos de Uso',
            ),
            CustomElevatedButtonWidget(
              onPressed: () =>
                  context.push('/profile/terms/single', extra: 'PRIVACY'),
              title: 'Políticas de Privacidade',
            ),
            CustomElevatedButtonWidget(
              onPressed: () => context.push('/profile/support-contact'),
              title: 'Contato e Suporte',
            ),
            CustomElevatedButtonWidget(
              onPressed: _logout,
              title: 'Sair do aplicativo',
              iconData: Icons.logout,
              iconSize: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _logout() {
    usuarioProvider.limparCampos();

    context.go('/');
  }
}
