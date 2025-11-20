import 'package:app_economize_mais/models/establishment_model.dart';
import 'package:app_economize_mais/models/product_model.dart';
import 'package:app_economize_mais/screens/cadastro/cadastro_senha_screen.dart';
import 'package:app_economize_mais/screens/terms/single_term_screen.dart';
import 'package:app_economize_mais/screens/terms/terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/anuncie%20conosco/anuncie_conosco_screen.dart';
import 'package:app_economize_mais/screens/cadastro/cadastro_endereco_screen.dart';
import 'package:app_economize_mais/screens/cadastro/cadastro_recuperar_senha_screen.dart';
import 'package:app_economize_mais/screens/cadastro/cadastro_screen.dart';
import 'package:app_economize_mais/screens/contato%20suporte/contato_suporte_screen.dart';
import 'package:app_economize_mais/screens/enderecos/enderecos_screen.dart';
import 'package:app_economize_mais/screens/home/home_screen.dart';
import 'package:app_economize_mais/screens/login/login_screen.dart';
import 'package:app_economize_mais/screens/negocio/negocio_screen.dart';
import 'package:app_economize_mais/screens/negocios%20detalhes/establishment_details_screen.dart';
import 'package:app_economize_mais/screens/negocios%20detalhes/widget/product_item_details_widget.dart';
import 'package:app_economize_mais/screens/perguntas%20frequentes/perguntas_frequentes_screen.dart';
import 'package:app_economize_mais/screens/profile/dados_perfil_screen.dart';
import 'package:app_economize_mais/screens/trocar%20senha/trocar_senha_screen.dart';

abstract class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/cadastro':
        return MaterialPageRoute(builder: (_) => const CadastroScreen());
      case '/cadastro/endereco':
        return MaterialPageRoute(
            builder: (_) => CadastroEnderecoScreen(
                userJson: (settings.arguments as Map)['userJson']));
      case '/cadastro/senha':
        return MaterialPageRoute(
            builder: (_) => CadastroSenhaScreen(
                userJson: (settings.arguments as Map)['userJson']));
      case '/cadastro/recuperar-senha':
        return MaterialPageRoute(
            builder: (_) => const CadastroRecuperarSenhaScreen());
      case '/terms':
        return MaterialPageRoute(builder: (_) => const TermsScreen());
      case '/terms/single':
        return MaterialPageRoute(
            builder: (_) =>
                SingleTermScreen(type: settings.arguments as String));
      case '/home':
        final userType = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => HomeScreen(type: userType));
      case '/home/empresas':
        final negocios = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => EmpresasScreen(negocios: negocios));
      case '/negocio-detalhes':
        final type =
            (settings.arguments as Map<String, dynamic>)['type'] as String;
        final establishment = (settings.arguments
            as Map<String, dynamic>)['establishment'] as EstablishmentModel;
        return MaterialPageRoute(
            builder: (_) => EstablishmentDetailsScreen(
                type: type, establishment: establishment));
      case '/produto-item-detalhes':
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
            builder: (_) => ProductItemDetailsWidget(product: product));
      case '/dados-perfil':
        return MaterialPageRoute(builder: (_) => const DadosPerfilScreen());
      case '/enderecos':
        return MaterialPageRoute(builder: (_) => const EnderecosScreen());
      case '/trocar-senha':
        return MaterialPageRoute(builder: (_) => const TrocarSenhaScreen());
      case '/perguntas-frequentes':
        return MaterialPageRoute(
            builder: (_) => const PerguntasFrequentesScreen());
      case '/contato-suporte':
        return MaterialPageRoute(builder: (_) => const ContatoSuporteScreen());
      case '/anuncie-conosco':
        return MaterialPageRoute(builder: (_) => const AnuncieConoscoScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
