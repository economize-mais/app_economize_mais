import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/negocios%20detalhes/widget/produto_item_widget.dart';

class NegocioProdutosWidget extends StatelessWidget {
  final Map<String, dynamic> produtos;

  const NegocioProdutosWidget({
    super.key,
    required this.produtos,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            produtos['tipo'],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 162,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: produtos['itens'].length,
              itemBuilder: (context, i) => ProdutoItemWidget(
                produto: produtos['itens'][i],
                tipo: produtos['tipo'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
