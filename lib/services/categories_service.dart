import 'package:app_economize_mais/utils/data/custom_dio.dart';

abstract class CategoriesService {
  static final _apiAuth = CustomDio.auth().dio;

  static Future<List> getCategories() async {
    try {
      final response = await _apiAuth.get('/categories');

      return List.from(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
