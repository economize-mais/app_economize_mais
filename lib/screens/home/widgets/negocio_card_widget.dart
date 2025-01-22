import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/endereco_unidade_widget.dart';

class NegocioCardWidget extends StatelessWidget {
  final Map<String, dynamic> empresa;
  final double width;
  final double height;

  const NegocioCardWidget({
    super.key,
    required this.empresa,
    this.width = 124,
    this.height = 105,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/negocio-detalhes', arguments: empresa),
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          margin: const EdgeInsets.only(top: 2, bottom: 9),
          color: AppScheme.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: FadeInImage(
                      placeholder: const AssetImage(
                        "assets/images/supermarket_placeholder.png",
                      ),
                      image: AssetImage(
                        "assets/images/${empresa['assetUrl']}",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  empresa['nome'],
                  style: TextStyle(
                    color: AppScheme.gray[4],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                EnderecoUnidadeWidget(
                  unidade: empresa['unidade'],
                  endereco: empresa['endereco'],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
