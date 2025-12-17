import 'package:app_economize_mais/services/shared_preferences_service.dart';
import 'package:app_economize_mais/utils/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String? accessToken = await SharedPreferencesService.getString(
        SharedPreferencesEnum.accessToken);

    options.headers = {
      'Authorization': 'Bearer $accessToken',
    };

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await SharedPreferencesService.clearAll();

      AppRoutes.navigatorStateKey.currentContext?.go('/', extra: true);
    }

    super.onError(err, handler);
  }
}
