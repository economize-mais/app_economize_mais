import 'package:app_economize_mais/models/category_model.dart';
import 'package:flutter/widgets.dart';

bool validateCategoryController(
    TextEditingController controller, List<CategoryModel> categoriesList) {
  if (controller.text == '') {
    return false;
  }

  final containTextInList =
      categoriesList.where((item) => item.name == controller.text).isNotEmpty;

  return containTextInList;
}
