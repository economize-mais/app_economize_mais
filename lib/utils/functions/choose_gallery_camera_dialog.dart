import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

Future<ImageSource?> chooseGalleryCameraDialog(BuildContext context) async {
  return await showDialog<ImageSource?>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppScheme.white,
      elevation: 2,
      shadowColor: AppScheme.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: AppScheme.lightGray),
      ),
      title: Text(
        'Escolha uma opção...',
        style: TextStyle(
          color: AppScheme.gray[4],
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          TextButton(
              onPressed: () => context.pop(ImageSource.gallery),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: Text('Pegar foto da galeria')),
          TextButton(
              onPressed: () => context.pop(ImageSource.camera),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: Text('Tirar foto pela câmera')),
        ],
      ),
    ),
  );
}
