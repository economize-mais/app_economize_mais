import 'package:app_economize_mais/utils/data/custom_dio.dart';

abstract class EstablishmentService {
  static final _api = CustomDio().dio;
  // static final _apiAuth = CustomDio.auth().dio;

  static Future<List> getEstablishmentTypes() async {
    try {
      final response = await _api.get('/establishment/types');

      return List.from(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
