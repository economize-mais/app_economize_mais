import 'dart:io';

import 'package:app_economize_mais/utils/widgets/labeled_outline_date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/announcement/widgets/image_picker_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class ProductContainerWidget extends StatelessWidget {
  final TextEditingController valorDeController;
  final TextEditingController valorParaController;
  final bool showValidade;
  final TextEditingController? validadeOfertaInicioController;
  final TextEditingController validadeOfertaFimController;
  final File? image;
  final Future Function()? selectImage;

  const ProductContainerWidget({
    super.key,
    required this.valorDeController,
    required this.valorParaController,
    this.showValidade = true,
    required this.validadeOfertaInicioController,
    required this.validadeOfertaFimController,
    this.image,
    this.selectImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 25),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppScheme.lightGray,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'VALOR',
            style: TextStyle(
              color: AppScheme.gray[4],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: LabeledOutlineTextFieldWidget(
                  controller: valorDeController,
                  label: 'De:',
                  fillColor: AppScheme.gray[1]!,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 90),
              Expanded(
                child: LabeledOutlineTextFieldWidget(
                  controller: valorParaController,
                  label: 'Para:',
                  fillColor: AppScheme.gray[1]!,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ..._buildOfferValidity(),
          ImagePickerWidget(
            image: image,
            onTap: selectImage,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOfferValidity() {
    if (!showValidade) {
      return [];
    }

    return [
      Text(
        'VALIDADE DA OFERTA',
        style: TextStyle(
          color: AppScheme.gray[4],
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 90,
        children: [
          if (validadeOfertaInicioController != null)
            Expanded(
              child: LabeledOutlineDatePicker(
                controller: validadeOfertaInicioController!,
                label: 'Início:',
                fillColor: AppScheme.gray[1]!,
              ),
            ),
          Expanded(
            child: LabeledOutlineDatePicker(
              controller: validadeOfertaFimController,
              label: 'Fim:',
              fillColor: AppScheme.gray[1]!,
              canPassMaxDate: true,
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
    ];
  }
}
