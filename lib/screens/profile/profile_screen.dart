import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/profile/widgets/profile_widget.dart';
import 'package:app_economize_mais/utils/widgets/custom_elevated_button_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UsuarioProvider usuarioProvider;
  late bool isUser;
  late String name;

  @override
  void initState() {
    super.initState();

    usuarioProvider = Provider.of(context, listen: false);
    final userModel = usuarioProvider.userModel!;
    isUser = userModel.userType == 'USER';
    name = isUser ? userModel.fullName : userModel.companyName!;
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
            ProfileWidget(
              name: name,
            ),
            CustomElevatedButtonWidget(
              onPressed: () => Navigator.pushNamed(context, '/dados-perfil'),
              title: 'Dados ${isUser ? 'Pessoais' : 'da Empresa'} ',
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
              onPressed: () => Navigator.pushNamed(context, '/terms/single',
                  arguments: 'USAGE'),
              title: 'Termos de Uso',
            ),
            CustomElevatedButtonWidget(
              onPressed: () => Navigator.pushNamed(context, '/terms/single',
                  arguments: 'PRIVACY'),
              title: 'Políticas de Privacidade',
            ),
            CustomElevatedButtonWidget(
              onPressed: () => Navigator.pushNamed(context, '/contato-suporte'),
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

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      ModalRoute.withName('/'),
    );
  }
}
