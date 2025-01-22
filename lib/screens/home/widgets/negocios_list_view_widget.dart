import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/home/widgets/anuncie_conosco_widget.dart';
import 'package:app_economize_mais/screens/home/widgets/negocio_card_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class NegociosListViewWidget extends StatelessWidget {
  final Map<String, dynamic> negocios;

  const NegociosListViewWidget({
    super.key,
    required this.negocios,
  });

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
              negocios['grupo'],
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
                arguments: negocios,
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
            itemCount: negocios['empresas'].length,
            separatorBuilder: (context, i) => const SizedBox(width: 10),
            itemBuilder: (context, i) => Visibility(
              visible: i < negocios['empresas'].length - 1,
              replacement: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NegocioCardWidget(
                    empresa: negocios['empresas'][i],
                  ),
                  const AnuncieConoscoWidget(),
                ],
              ),
              child: NegocioCardWidget(
                empresa: negocios['empresas'][i],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
