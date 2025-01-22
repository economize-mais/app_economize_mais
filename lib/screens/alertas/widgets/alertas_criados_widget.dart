import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/alertas/widgets/alerta_list_tile_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class AlertasCriadosWidget extends StatefulWidget {
  final List listaAlertas;

  const AlertasCriadosWidget({
    super.key,
    required this.listaAlertas,
  });

  @override
  State<AlertasCriadosWidget> createState() => _AlertasCriadosWidgetState();
}

class _AlertasCriadosWidgetState extends State<AlertasCriadosWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Alertas Criados',
          style: TextStyle(
            color: AppScheme.gray[4],
            fontSize: 12,
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 10),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: widget.listaAlertas.length,
          itemBuilder: (context, index) => AlertaListTileWidget(
            alerta: widget.listaAlertas[index],
            onDelete: () => setState(() => widget.listaAlertas.removeAt(index)),
          ),
        ),
      ],
    );
  }
}
