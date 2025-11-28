import 'package:app_economize_mais/models/product_model.dart';
import 'package:app_economize_mais/utils/functions/format_types.dart';
import 'package:app_economize_mais/utils/widgets/custom_fade_in_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:go_router/go_router.dart';

class ProductItemWidget extends StatelessWidget {
  final String type;
  final ProductModel product;

  const ProductItemWidget({
    super.key,
    required this.product,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '/home/product-item-details',
        extra: product,
      ),
      child: SizedBox(
        width: 124,
        height: 146,
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
                      CustomFadeInImageWidget(
                        height: 67,
                        width: 78,
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          product.imageUrl ?? '',
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: AppScheme.brightGreen,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: FittedBox(
                              child: Text(
                                '-${formatDecimalNumber(product.discountPercent)}%',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.name,
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
                      'R\$ ${product.priceOriginal}',
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
                        'R\$ ${product.priceOffer}',
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
