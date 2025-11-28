import 'package:app_economize_mais/models/establishment_types_model.dart';
import 'package:app_economize_mais/services/establishment_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class EstablishmentsProvider extends ChangeNotifier {
  List<EstablishmentTypesModel> _establishmentsList = [];
  List<EstablishmentTypesModel> get establishmentsList =>
      List.unmodifiable(_establishmentsList);

  bool hasError = false;
  String errorMessage = '';

  Future getEstablishmentsList() async {
    try {
      _establishmentsList = [];
      _setError(false);

      final response = await EstablishmentService.getEstablishmentTypes();
      for (var i = 0; i < response.length; i++) {
        _establishmentsList.add(EstablishmentTypesModel.fromJson(response[i]));
      }
    } catch (e) {
      _setError(true,
          message: e is DioException
              ? e.response?.data['message']
              : 'Um erro inesperado ocorreu');
    } finally {
      notifyListeners();
    }
  }

  void _setError(bool newValue, {String? message}) {
    hasError = newValue;
    errorMessage = '';

    if (message != null) {
      errorMessage = message;
    }
  }
}
