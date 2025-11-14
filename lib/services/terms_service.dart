import 'package:app_economize_mais/utils/data/custom_dio.dart';

abstract class TermsService {
  static final _apiAuth = CustomDio.auth().dio;

  static Future getTerms(String type) async {
    try {
      final response = await _apiAuth.get(
        '/terms/$type',
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future acceptTerms(int id) async {
    try {
      final response = await _apiAuth.post('/terms/accept', data: {'id': id});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
