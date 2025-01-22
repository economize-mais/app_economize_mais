import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class CategoriasListViewWidget extends StatelessWidget {
  const CategoriasListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const listaCategorias = [
      'Limpeza',
      'Higiene Pessoal',
      'Carnes',
      'Bebês',
      'Frutas',
      'Hortaliças',
      'Conveniência',
      'Legumes',
      'Padaria',
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 60,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listaCategorias.length,
        separatorBuilder: (context, i) => const SizedBox(width: 10),
        itemBuilder: (context, i) => SizedBox(
          width: 120,
          child: Card(
            margin: EdgeInsets.zero,
            color: AppScheme.brightGreen,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      listaCategorias[i],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}