import 'package:app_economize_mais/models/product_model.dart';

class ProductsEstablishmentModel {
  final String categoryId;
  final String categoryName;
  final List<ProductModel> products;

  ProductsEstablishmentModel.fromJson(Map<String, dynamic> json)
      : categoryId = json['categoryId'],
        categoryName = json['categoryName'],
        products = (json['products'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
}
