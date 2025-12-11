import 'package:app_economize_mais/models/product_model.dart';
import 'package:app_economize_mais/models/products_establishment_model.dart';
import 'package:app_economize_mais/services/products_service.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ProductsEstablishmentProvider extends ChangeNotifier {
  List<ProductsEstablishmentModel> _productsEstablishment = [];
  List<ProductsEstablishmentModel> get productsEstablishment =>
      List.unmodifiable(_productsEstablishment);

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  Future getProductsEstablishment(String id) async {
    try {
      _productsEstablishment = [];
      _setError(false);
      _setIsLoading(true);

      final response = await ProductsService.getProductsEstablishment(id);
      _productsEstablishment = response
          .map((item) => ProductsEstablishmentModel.fromJson(item))
          .toList();
    } catch (e) {
      _setError(true,
          message: e is DioException
              ? e.response?.data['message']
              : 'Um erro inesperado ocorreu');
    } finally {
      _setIsLoading(false);
    }
  }

  Future deleteProduct(String productId, String categoryId) async {
    try {
      _setError(false);

      await ProductsService.deleteProduct(productId);
      _removeProductFromList(productId, categoryId);
    } catch (e) {
      _setError(true,
          message: e is DioException
              ? e.response?.data['message']
              : 'Um erro inesperado ocorreu');
    } finally {
      notifyListeners();
    }
  }

  void _removeProductFromList(String productId, String categoryId) {
    final currentProductsEstablishment = _productsEstablishment
        .firstWhereOrNull((item) => item.categoryId == categoryId);
    if (currentProductsEstablishment == null) {
      return;
    }

    currentProductsEstablishment.products
        .removeWhere((product) => product.id == productId);

    if (currentProductsEstablishment.products.isEmpty) {
      _productsEstablishment
          .removeWhere((item) => item.categoryId == categoryId);
    }
  }

  void patchProductFromList(
      String productId, String categoryId, ProductModel product) {
    final currentProductsEstablishment = _productsEstablishment
        .firstWhereOrNull((item) => item.categoryId == categoryId);
    if (currentProductsEstablishment == null) {
      return;
    }

    final currentProductIndex = currentProductsEstablishment.products
        .indexWhere((item) => item.id == productId);
    if (currentProductIndex < 0) {
      return;
    }

    currentProductsEstablishment.products[currentProductIndex] = product;
    notifyListeners();
  }

  ProductModel findProductById(String id, String categoryId) {
    final categoryList = _productsEstablishment
        .firstWhere((item) => item.categoryId == categoryId);
    final product = categoryList.products.firstWhere((item) => item.id == id);

    return product;
  }

  void _setIsLoading(bool newValue) {
    isLoading = newValue;
    notifyListeners();
  }

  void _setError(bool newValue, {String? message}) {
    hasError = newValue;
    errorMessage = '';

    if (message != null) {
      errorMessage = message;
    }
  }
}
