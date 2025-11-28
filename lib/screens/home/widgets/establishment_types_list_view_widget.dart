import 'package:app_economize_mais/models/establishment_types_model.dart';
import 'package:app_economize_mais/screens/home/widgets/anuncie_conosco_widget.dart';
import 'package:app_economize_mais/screens/home/widgets/establishment_card_widget.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EstablishmentTypesListViewWidget extends StatelessWidget {
  final EstablishmentTypesModel establishmentTypes;

  const EstablishmentTypesListViewWidget(
      {super.key, required this.establishmentTypes});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              establishmentTypes.name,
              style: TextStyle(
                color: AppScheme.gray[4],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => context.push(
                '/home/establishments',
                extra: establishmentTypes,
              ),
              style: TextButton.styleFrom(
                visualDensity: const VisualDensity(vertical: -4),
              ),
              child: const Text(
                'Ver todos',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 130,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: establishmentTypes.establishments.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) => Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EstablishmentCardWidget(
                  type: establishmentTypes.name,
                  establishment: establishmentTypes.establishments[i],
                ),
                if (i == establishmentTypes.establishments.length - 1)
                  const AnuncieConoscoWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
