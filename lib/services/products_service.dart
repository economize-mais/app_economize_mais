import 'package:app_economize_mais/utils/data/custom_dio.dart';

abstract class ProductsService {
  static final _apiAuth = CustomDio.auth().dio;

  static Future<List> getProductsEstablishment(String id) async {
    try {
      final response = await _apiAuth.get('/products/establishment/$id');

      return List.from(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future postProduct(Map json) async {
    try {
      final response = await _apiAuth.post('/products', data: json);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future deleteProduct(String id) async {
    try {
      final response = await _apiAuth.delete('/products/$id');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
