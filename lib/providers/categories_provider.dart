import 'package:app_economize_mais/models/category_model.dart';
import 'package:app_economize_mais/services/categories_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class CategoriesProvider extends ChangeNotifier {
  List<CategoryModel> _categoriesList = [];
  List<CategoryModel> get categoriesList => List.unmodifiable(_categoriesList);

  bool hasError = false;
  String errorMessage = '';

  Future getCategories() async {
    try {
      _categoriesList = [];
      _setError(false);

      final response = await CategoriesService.getCategories();
      _categoriesList =
          response.map((item) => CategoryModel.fromJson(item)).toList();
    } catch (e) {
      _setError(true,
          message: e is DioException
              ? e.response?.data['message']
              : 'Um erro inesperado ocorreu');
    } finally {
      notifyListeners();
    }
  }

  bool isAlcoholicBeverage(String categoryId) {
    return _categoriesList.indexWhere((item) =>
                item.id == categoryId && item.name == "Bebidas Alcoólicas") >=
            0
        ? true
        : false;
  }

  void _setError(bool newValue, {String? message}) {
    hasError = newValue;
    errorMessage = '';

    if (message != null) {
      errorMessage = message;
    }
  }
}
