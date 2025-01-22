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
import 'package:app_economize_mais/screens/negocios%20detalhes/negocio_detalhes_screen.dart';
import 'package:app_economize_mais/screens/negocios%20detalhes/widget/produto_item_detalhe_widget.dart';
import 'package:app_economize_mais/screens/perguntas%20frequentes/perguntas_frequentes_screen.dart';
import 'package:app_economize_mais/screens/profile/dados_empresa_screen.dart';
import 'package:app_economize_mais/screens/trocar%20senha/trocar_senha_screen.dart';

abstract class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/cadastro':
        return MaterialPageRoute(builder: (_) => const CadastroScreen());
      case '/cadastro/endereco':
        return MaterialPageRoute(
            builder: (_) => const CadastroEnderecoScreen());
      case '/cadastro/recuperar-senha':
        return MaterialPageRoute(
            builder: (_) => const CadastroRecuperarSenhaScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/home/empresas':
        final negocios = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => EmpresasScreen(negocios: negocios));
      case '/negocio-detalhes':
        final empresa = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => NegocioDetalhesScreen(empresa: empresa));
      case '/produto-item-detalhes':
        final produto = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ProdutoItemDetalheWidget(produto: produto));
      case '/dados-empresa':
        return MaterialPageRoute(builder: (_) => const DadosEmpresaScreen());
      case '/enderecos':
        return MaterialPageRoute(builder: (_) => const EnderecosScreen());
      case '/trocar-senha':
        return MaterialPageRoute(builder: (_) => const TrocarSenhaScreen());
      case '/perguntas-frequentes':
        return MaterialPageRoute(builder: (_) => const PerguntasFrequentesScreen());
      case '/contato-suporte':
        return MaterialPageRoute(builder: (_) => const ContatoSuporteScreen());
      case '/anuncie-conosco':
        return MaterialPageRoute(builder: (_) => const AnuncieConoscoScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
