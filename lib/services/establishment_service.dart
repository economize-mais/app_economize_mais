import 'package:app_economize_mais/utils/data/custom_dio.dart';

abstract class EstablishmentService {
  static final _apiAuth = CustomDio.auth().dio;

  static Future getEstablishmentTypes() async {
    try {
      final response = await _apiAuth.get('/establishment/types');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
