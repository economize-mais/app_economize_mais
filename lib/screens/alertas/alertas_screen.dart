import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/alertas/widgets/alertas_criados_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class AlertasScreen extends StatefulWidget {
  const AlertasScreen({super.key});

  @override
  State<AlertasScreen> createState() => _AlertasScreenState();
}

class _AlertasScreenState extends State<AlertasScreen> {
  final TextEditingController produtoBuscadoController =
      TextEditingController();

  List listaAlertas = [
    'Frango',
    'Leite',
    'Banana',
    'Fralda',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        applyLeading: false,
        title: 'Alertas',
        hideActions: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Crie alertas com seus produtos favoritos que te avisaremos assim que entrarem em promoção!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppScheme.gray[4],
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: LabeledOutlineTextFieldWidget(
                controller: produtoBuscadoController,
                label: 'Digite Produto Buscado',
              ),
            ),
            FilledButton(
              onPressed: () {
                if (produtoBuscadoController.text.trim().isEmpty) return;

                setState(() {
                  listaAlertas.add(produtoBuscadoController.text);
                  produtoBuscadoController.clear();
                });
              },
              child: const Text('Criar Alerta'),
            ),
            const SizedBox(height: 25),
            AlertasCriadosWidget(
              listaAlertas: listaAlertas,
            ),
          ],
        ),
      ),
    );
  }
}
