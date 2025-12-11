import 'dart:io';

import 'package:app_economize_mais/models/upload_model.dart';
import 'package:app_economize_mais/providers/product_provider.dart';
import 'package:app_economize_mais/utils/widgets/popup_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<UploadModel?> sendProductImage(
    BuildContext context, File image, String type) async {
  final ProductProvider productProvider = Provider.of(context, listen: false);
  final responseImage = await productProvider.uploadImage(image, type);

  if (!context.mounted) return null;

  if (productProvider.hasError) {
    showDialog(
      context: context,
      builder: (context) =>
          PopupErrorWidget(content: productProvider.errorMessage),
    );

    return null;
  }

  return responseImage;
}
