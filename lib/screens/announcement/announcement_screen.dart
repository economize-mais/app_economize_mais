import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/announcement/widgets/product_container_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_dropdown_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController marcaFabricanteController =
      TextEditingController();
  final TextEditingController pesoLiquidoController = TextEditingController();
  final TextEditingController dataValidadeController = TextEditingController();
  final TextEditingController valorDeController = TextEditingController();
  final TextEditingController valorParaController = TextEditingController();
  final TextEditingController validadeOfertaInicioController =
      TextEditingController();
  final TextEditingController validadeOfertaFimController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        applyLeading: false,
        title: 'Anúncio',
        hideActions: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LabeledDropdownWidget(
              controller: categoriaController,
              label: 'Categoria',
              value: categoriaController.text,
              items: const [
                '',
                'Supermercados',
                'Farmácias',
                'Hortifrutis',
                'Cosméticos',
                'Serviços',
              ],
              onChanged: (value) =>
                  setState(() => categoriaController.text = value ?? ''),
            ),
            const SizedBox(height: 15),
            LabeledOutlineTextFieldWidget(
              controller: descricaoController,
              label: 'Descrição',
            ),
            const SizedBox(height: 15),
            LabeledOutlineTextFieldWidget(
              controller: marcaFabricanteController,
              label: 'Marca/Fabricante',
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: LabeledOutlineTextFieldWidget(
                    controller: pesoLiquidoController,
                    label: 'Peso Líquido',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: LabeledOutlineTextFieldWidget(
                    controller: dataValidadeController,
                    label: 'Data de Validade',
                  ),
                ),
              ],
            ),
            ProductContainerWidget(
              valorDeController: valorDeController,
              valorParaController: valorParaController,
              showValidade: categoriaController.text != 'Serviços',
              validadeOfertaInicioController: validadeOfertaInicioController,
              validadeOfertaFimController: validadeOfertaFimController,
            ),
            FilledButton(
              onPressed: () {},
              child: const Text('Postar'),
            ),
          ],
        ),
      ),
    );
  }
}
