import 'package:app_economize_mais/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/home/widgets/anuncie_conosco_widget.dart';
import 'package:app_economize_mais/screens/home/widgets/negocio_card_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:provider/provider.dart';

class NegociosListViewWidget extends StatefulWidget {
  final Map<String, dynamic> negocios;

  const NegociosListViewWidget({
    super.key,
    required this.negocios,
  });

  @override
  State<NegociosListViewWidget> createState() => _NegociosListViewWidgetState();
}

class _NegociosListViewWidgetState extends State<NegociosListViewWidget> {
  bool isUser = true;

  @override
  void initState() {
    super.initState();

    final usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);
    isUser = usuarioProvider.userModel!.userType == 'USER';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.negocios['grupo'],
              style: TextStyle(
                color: AppScheme.gray[4],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(
                context,
                '/home/empresas',
                arguments: widget.negocios,
              ),
              style: TextButton.styleFrom(
                visualDensity: const VisualDensity(vertical: -4),
              ),
              child: const Text(
                'Ver todos',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 130,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: widget.negocios['empresas'].length,
            separatorBuilder: (context, i) => const SizedBox(width: 10),
            itemBuilder: (context, i) => Visibility(
              visible: i < widget.negocios['empresas'].length - 1,
              replacement: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NegocioCardWidget(
                    empresa: widget.negocios['empresas'][i],
                  ),
                  if (!isUser) const AnuncieConoscoWidget(),
                ],
              ),
              child: NegocioCardWidget(
                empresa: widget.negocios['empresas'][i],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
