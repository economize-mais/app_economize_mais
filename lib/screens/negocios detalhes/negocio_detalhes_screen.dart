import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/negocios%20detalhes/widget/negocio_produtos_widget.dart';
import 'package:app_economize_mais/utils/widgets/endereco_unidade_widget.dart';
import 'package:app_economize_mais/utils/widgets/filter_search_text_field_widget.dart';
import 'package:app_economize_mais/utils/widgets/general_app_bar_widget.dart';

class NegocioDetalhesScreen extends StatelessWidget {
  final Map<String, dynamic> empresa;

  const NegocioDetalhesScreen({
    super.key,
    required this.empresa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: ''),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FilterSearchTextFieldWidget(),
            const SizedBox(height: 15),
            Text(
              empresa['tipo'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            FadeInImage(
              height: 79,
              width: 163,
              fit: BoxFit.contain,
              placeholder: const AssetImage(
                "assets/images/supermarket_placeholder.png",
              ),
              image: AssetImage(
                "assets/images/${empresa['assetUrl']}",
              ),
            ),
            const SizedBox(height: 2),
            EnderecoUnidadeWidget(
              unidade: empresa['unidade'],
              endereco: empresa['endereco'],
              fontSize: 12,
            ),
            const Divider(
              height: 4,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            ...(empresa['produtos'] as List)
                .map((produtos) => NegocioProdutosWidget(
                      produtos: produtos,
                    )),
          ],
        ),
      ),
    );
  }
}
