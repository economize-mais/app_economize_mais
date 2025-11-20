import 'dart:io';

import 'package:app_economize_mais/models/upload_model.dart';
import 'package:app_economize_mais/services/products_service.dart';
import 'package:app_economize_mais/services/uploads_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  Future<UploadModel?> uploadImage(File imageFile, String type) async {
    UploadModel? uploadResponse;

    try {
      _setError(false);

      final response = await UploadsService.uploadImage(imageFile, type);
      uploadResponse = UploadModel.fromJson(response);
    } catch (e) {
      _setError(true,
          message: e is DioException
              ? e.response?.data['message']
              : 'Um erro inesperado ocorreu');
    } finally {
      notifyListeners();
    }

    return uploadResponse;
  }

  Future postProduct(Map<String, dynamic> json) async {
    try {
      _setError(false);

      await ProductsService.postProduct(json);
    } catch (e) {
      _setError(true,
          message: e is DioException
              ? e.response?.data['message']
              : 'Um erro inesperado ocorreu');
    } finally {
      notifyListeners();
    }
  }

  void setIsLoading(bool newValue) {
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
