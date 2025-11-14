import 'package:app_economize_mais/utils/data/custom_dio.dart';

abstract class ZipcodeService {
  static final _api = CustomDio().dio;

  static Future getCEP(String cep) async {
    try {
      final response = await _api.get('/zipCode/$cep');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
