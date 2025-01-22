import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'IMAGEM DO PRODUTO',
            style: TextStyle(
              color: AppScheme.gray[4],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 150,
            width: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppScheme.gray[1]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              Icons.camera_alt,
              size: 74,
              color: AppScheme.gray[3],
            ),
          ),
        ],
      ),
    );
  }
}
