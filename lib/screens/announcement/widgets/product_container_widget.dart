import 'dart:io';

import 'package:app_economize_mais/utils/widgets/checkbox_list_tile_item_widget.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/screens/announcement/widgets/image_picker_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:app_economize_mais/utils/widgets/labeled_outline_text_field_widget.dart';

class ProductContainerWidget extends StatefulWidget {
  final TextEditingController valorDeController;
  final TextEditingController valorParaController;
  final bool showValidade;
  final TextEditingController validadeOfertaInicioController;
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
  State<ProductContainerWidget> createState() => _ProductContainerWidgetState();
}

class _ProductContainerWidgetState extends State<ProductContainerWidget> {
  bool naoTemValidade = false;

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
                  controller: widget.valorDeController,
                  label: 'De:',
                  fillColor: AppScheme.gray[1]!,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 90),
              Expanded(
                child: LabeledOutlineTextFieldWidget(
                  controller: widget.valorParaController,
                  label: 'Para:',
                  fillColor: AppScheme.gray[1]!,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          CheckboxListTileItemWidget(
            valor: naoTemValidade,
            titulo: 'Este produto não tem validade.',
            onChanged: (value) =>
                setState(() => naoTemValidade = value ?? false),
          ),
          const SizedBox(height: 5),
          if (widget.showValidade && !naoTemValidade)
            Text(
              'VALIDADE DA OFERTA',
              style: TextStyle(
                color: AppScheme.gray[4],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (widget.showValidade && !naoTemValidade)
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: LabeledOutlineDatePicker(
                    controller: widget.validadeOfertaInicioController,
                    label: 'Início:',
                    fillColor: AppScheme.gray[1]!,
                  ),
                ),
                const SizedBox(width: 90),
                Expanded(
                  child: LabeledOutlineDatePicker(
                    controller: widget.validadeOfertaFimController,
                    label: 'Fim:',
                    fillColor: AppScheme.gray[1]!,
                    canPassMaxDate: true,
                  ),
                ),
              ],
            ),
          ImagePickerWidget(
            image: widget.image,
            onTap: widget.selectImage,
          ),
        ],
      ),
    );
  }
}
