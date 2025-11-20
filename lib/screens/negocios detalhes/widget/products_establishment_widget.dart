import 'package:app_economize_mais/models/products_establishment_model.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/negocios%20detalhes/widget/product_item_widget.dart';

class ProductsEstablishmentWidget extends StatelessWidget {
  final String type;
  final ProductsEstablishmentModel productsEstablishment;

  const ProductsEstablishmentWidget({
    super.key,
    required this.type,
    required this.productsEstablishment,
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
            productsEstablishment.categoryName,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 162,
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: productsEstablishment.products.length,
              itemBuilder: (context, i) => ProductItemWidget(
                type: type,
                product: productsEstablishment.products[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
