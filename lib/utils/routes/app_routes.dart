import 'package:app_economize_mais/models/establishment_model.dart';
import 'package:app_economize_mais/models/establishment_types_model.dart';
import 'package:app_economize_mais/models/product_model.dart';
import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/screens/alertas/alertas_screen.dart';
import 'package:app_economize_mais/screens/announcement/announcement_screen.dart';
import 'package:app_economize_mais/screens/cadastro/cadastro_senha_screen.dart';
import 'package:app_economize_mais/screens/home/initial_screen.dart';
import 'package:app_economize_mais/screens/home/widgets/home_scaffold_widget.dart';
import 'package:app_economize_mais/screens/profile/profile_screen.dart';
import 'package:app_economize_mais/screens/terms/single_term_screen.dart';
import 'package:app_economize_mais/screens/terms/terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/anuncie%20conosco/anuncie_conosco_screen.dart';
import 'package:app_economize_mais/screens/cadastro/cadastro_endereco_screen.dart';
import 'package:app_economize_mais/screens/cadastro/cadastro_recuperar_senha_screen.dart';
import 'package:app_economize_mais/screens/cadastro/cadastro_screen.dart';
import 'package:app_economize_mais/screens/contato%20suporte/contato_suporte_screen.dart';
import 'package:app_economize_mais/screens/enderecos/enderecos_screen.dart';
import 'package:app_economize_mais/screens/login/login_screen.dart';
import 'package:app_economize_mais/screens/negocio/negocio_screen.dart';
import 'package:app_economize_mais/screens/negocios%20detalhes/establishment_details_screen.dart';
import 'package:app_economize_mais/screens/negocios%20detalhes/widget/product_item_details_widget.dart';
import 'package:app_economize_mais/screens/perguntas%20frequentes/perguntas_frequentes_screen.dart';
import 'package:app_economize_mais/screens/profile/dados_perfil_screen.dart';
import 'package:app_economize_mais/screens/trocar%20senha/trocar_senha_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

abstract class AppRoutes {
  static final navigatorStateKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: navigatorStateKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final unauthorizedAccess = state.extra as bool? ?? false;

          return LoginScreen(
            unauthorizedAccess: unauthorizedAccess,
          );
        },
      ),
      GoRoute(
        path: '/advertise-with-us',
        builder: (context, state) => AnuncieConoscoScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => CadastroScreen(),
      ),
      GoRoute(
        path: '/register/address',
        builder: (context, state) {
          final userJson = state.extra as Map<String, dynamic>;

          return CadastroEnderecoScreen(
            userJson: userJson,
          );
        },
      ),
      GoRoute(
        path: '/register/password',
        builder: (context, state) {
          final userJson = state.extra as Map<String, dynamic>;

          return CadastroSenhaScreen(userJson: userJson);
        },
      ),
      GoRoute(
        path: '/register/recover-password',
        builder: (context, state) => CadastroRecuperarSenhaScreen(),
      ),
      GoRoute(
        path: '/terms',
        builder: (context, state) => TermsScreen(),
      ),
      GoRoute(
        path: '/product-item-details',
        builder: (context, state) {
          final product = state.extra as ProductModel;

          return ProductItemDetailsWidget(product: product);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeScaffoldWidget(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const InitialScreen(),
                routes: [
                  GoRoute(
                    path: '/establishments',
                    builder: (context, state) {
                      final establishments =
                          state.extra as EstablishmentTypesModel;

                      return EmpresasScreen(
                          establishmentsTypes: establishments);
                    },
                  ),
                  GoRoute(
                    path: '/establishment-details',
                    builder: (context, state) {
                      final type = (state.extra as Map)['type'] as String;
                      final establishment = (state.extra
                          as Map)['establishment'] as EstablishmentModel;

                      return EstablishmentDetailsScreen(
                          type: type, establishment: establishment);
                    },
                  ),
                  GoRoute(
                    path: '/product-item-details',
                    builder: (context, state) {
                      final product = state.extra as ProductModel;

                      return ProductItemDetailsWidget(product: product);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/announcements',
                builder: (context, state) {
                  final UsuarioProvider provider =
                      Provider.of(context, listen: false);
                  final userType = provider.userModel!.type;

                  return userType == 'USER'
                      ? const AlertasScreen()
                      : AnnouncementScreen();
                },
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: '/profile-data',
                    builder: (context, state) => DadosPerfilScreen(),
                  ),
                  GoRoute(
                    path: '/addresses',
                    builder: (context, state) => EnderecosScreen(),
                  ),
                  GoRoute(
                    path: '/change-password',
                    builder: (context, state) => TrocarSenhaScreen(),
                  ),
                  GoRoute(
                    path: '/common-questions',
                    builder: (context, state) => PerguntasFrequentesScreen(),
                  ),
                  GoRoute(
                    path: '/terms/single',
                    builder: (context, state) {
                      final type = state.extra as String;

                      return SingleTermScreen(type: type);
                    },
                  ),
                  GoRoute(
                    path: '/support-contact',
                    builder: (context, state) => ContatoSuporteScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
