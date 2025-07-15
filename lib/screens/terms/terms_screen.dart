import 'package:app_economize_mais/models/term_model.dart';
import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  late UsuarioProvider usuarioProvider;

  bool loadingTerms = true;
  List<TermModel> terms = [];
  int currentIndex = 0;
  bool acceptance = false;

  @override
  void initState() {
    super.initState();

    usuarioProvider = Provider.of(context, listen: false);

    _inicializar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                'Aceite os termos de uso e privacidade',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: _buildTerms(),
                ),
              ),
              if (!loadingTerms)
                CheckboxListTile(
                  value: acceptance,
                  onChanged: (value) =>
                      setState(() => acceptance = value ?? false),
                  dense: true,
                  activeColor: AppScheme.brightGreen,
                  title: Text(
                    'Concordo com os termos e condições',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                child: FilledButton(
                  onPressed: _aceitarTermos,
                  child: const Text('Continuar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTerms() {
    if (loadingTerms) {
      return const Center(
        child: CustomCircularProgressIndicator(
          text: 'Carregando termos...',
        ),
      );
    }

    final currentTerm = terms[currentIndex];
    final webViewController = WebViewController()
      ..loadHtmlString(currentTerm.html);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: () => setState(() => currentIndex = 0),
              style: TextButton.styleFrom(
                backgroundColor: currentIndex == 0
                    ? AppScheme.brightGreen
                    : AppScheme.gray[2],
                foregroundColor: AppScheme.gray[4],
                textStyle: const TextStyle(decoration: TextDecoration.none),
              ),
              child: const Text('TERMOS DE USO'),
            ),
            TextButton(
              onPressed: () => setState(() => currentIndex = 1),
              style: TextButton.styleFrom(
                backgroundColor: currentIndex == 1
                    ? AppScheme.brightGreen
                    : AppScheme.gray[2],
                foregroundColor: AppScheme.gray[4],
                textStyle: const TextStyle(decoration: TextDecoration.none),
              ),
              child: const Text('PRIVACIDADE'),
            ),
          ],
        ),
        Expanded(
          child: WebViewWidget(
            controller: webViewController,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => setState(() => currentIndex = 0),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: currentIndex == 0
                    ? AppScheme.brightGreen
                    : AppScheme.gray[2],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => setState(() => currentIndex = 1),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: currentIndex == 1
                    ? AppScheme.brightGreen
                    : AppScheme.gray[2],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future _aceitarTermos() async {
    if (!acceptance) {
      showDialog(
        context: context,
        builder: (context) => const PopupErrorWidget(
          content: 'É necessário aceitar os termos e condições',
        ),
      );
      return;
    }

    try {
      await Future.wait([
        usuarioProvider.aceitarTermos(terms[0].id),
        usuarioProvider.aceitarTermos(terms[1].id),
      ]);

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
          content: usuarioProvider.errorMessage,
        ),
      );
      return;
    }
  }

  Future _inicializar() async {
    try {
      List<TermModel> auxTerms = await Future.wait([
        usuarioProvider.pegarTermo('USAGE'),
        usuarioProvider.pegarTermo('PRIVACY'),
      ]);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingTerms = false;
          terms = auxTerms;
        });
      });
    } catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
          content: usuarioProvider.errorMessage,
        ),
      ).then((_) => Navigator.popUntil(context, (route) => route.isFirst));
      return;
    }
  }
}
