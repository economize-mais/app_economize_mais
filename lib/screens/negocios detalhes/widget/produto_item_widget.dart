import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class ProdutoItemWidget extends StatelessWidget {
  final Map<String, dynamic> produto;
  final String tipo;
  final double width;
  final double height;

  const ProdutoItemWidget({
    super.key,
    required this.produto,
    required this.tipo,
    this.width = 124,
    this.height = 146,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/produto-item-detalhes',
        arguments: produto,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          elevation: 2,
          color: AppScheme.white,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FadeInImage(
                        height: 67,
                        width: 78,
                        fit: BoxFit.contain,
                        placeholder: const AssetImage(
                          "assets/images/supermarket_placeholder.png",
                        ),
                        image: AssetImage(
                          "assets/images/supermercados/${produto['assetUrl']}",
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppScheme.brightGreen,
                          child: Text(
                            '-${produto['desconto']}',
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  produto['nome'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppScheme.gray[4],
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'R\$ ${produto['precoAntigo']}',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppScheme.red,
                        color: AppScheme.red,
                        fontSize: 8,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppScheme.brightGreen,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'R\$ ${produto['precoComDesconto']}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
