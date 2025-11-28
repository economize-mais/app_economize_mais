import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:app_economize_mais/utils/widgets/custom_circular_progress_indicator.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleTermScreen extends StatefulWidget {
  final String type;

  const SingleTermScreen({
    super.key,
    required this.type,
  });

  @override
  State<SingleTermScreen> createState() => _SingleTermScreenState();
}

class _SingleTermScreenState extends State<SingleTermScreen> {
  late UsuarioProvider usuarioProvider;

  bool loading = true;
  String term = '';

  @override
  void initState() {
    super.initState();

    usuarioProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) => _inicializar());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        title: widget.type == 'USAGE'
            ? 'Termos de Uso'
            : 'Políticas de Privacidade',
        hideActions: true,
      ),
      body: _buildTerm(),
    );
  }

  Future _inicializar() async {
    try {
      final responseTerm = await usuarioProvider.pegarTermo(widget.type);

      setState(() {
        loading = false;
        term = responseTerm.html;
      });
    } catch (e) {
      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) => PopupErrorWidget(
          content: usuarioProvider.errorMessage,
        ),
      );
      if (!mounted) return;

      context.pop();
    }
  }

  Widget _buildTerm() {
    if (loading) {
      return Center(
        child: CustomCircularProgressIndicator(
          text:
              'Carregando ${widget.type == 'USAGE' ? 'Termos de Uso' : 'Políticas de Privacidade'}...',
        ),
      );
    }

    final controller = WebViewController()..loadHtmlString(term);

    return WebViewWidget(controller: controller);
  }
}
